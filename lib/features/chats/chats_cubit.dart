import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/chats/chats_state.dart';
import '../../di/di.dart';
import '../../services/store_service.dart';
import 'package:messenger/utils/extensions.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsState()) {
    getIt.get<StoreService>().userChatsStreamTyped().listen((chats) {
      safeEmit(ChatsState(chats: chats));
    });
  }
}
