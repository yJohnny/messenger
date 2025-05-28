import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String? uid, email, name, fcmToken;

  UserModel.fromJson(Map<String, dynamic> json)
    : uid = json['uid'],
      email = json['email'],
      name = json['name'],
      fcmToken = json['fcmToken'];

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}
