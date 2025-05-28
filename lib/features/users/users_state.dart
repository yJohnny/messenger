import 'package:equatable/equatable.dart';
import 'package:messenger/models/user_model.dart';

class UsersState extends Equatable {
  final List<UserModel>? allUsers;

  const UsersState({this.allUsers});

  @override
  // TODO: implement props
  List<Object?> get props => [allUsers];
}
