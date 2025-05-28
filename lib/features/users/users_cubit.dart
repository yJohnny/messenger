import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/users/users_state.dart';
import 'package:messenger/models/user_model.dart';
import 'package:messenger/utils/extensions.dart';
import '../../di/di.dart';
import '../../services/store_service.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState()) {
    getIt.get<StoreService>().usersStream().listen((users) {
      safeEmit(UsersState(allUsers: users));
    });
  }

  UserModel? getUserById(String userId) {
    final users = state.allUsers?.where((eachUser) => eachUser.uid == userId);

    if (users?.isNotEmpty == true) {
      return users!.first;
    }
    return null;
  }
}
