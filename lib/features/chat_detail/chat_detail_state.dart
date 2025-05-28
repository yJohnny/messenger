import 'package:equatable/equatable.dart';
import 'package:messenger/models/message_model.dart';

class ChatDetailState extends Equatable {
  final List<MessageModel>? messages;

  const ChatDetailState({this.messages});

  @override
  // TODO: implement props
  List<Object?> get props => [messages];
}
