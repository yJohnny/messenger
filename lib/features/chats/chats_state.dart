import 'package:equatable/equatable.dart';
import 'package:messenger/models/chat_model.dart';

class ChatsState extends Equatable{
  final List<ChatModel>? chats;

  const ChatsState({this.chats});

  @override
  // TODO: implement props
  List<Object?> get props => [chats];
}