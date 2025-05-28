import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable{
  final String messageId, senderId, text;
  final DateTime time;

  MessageModel.fromJson(Map<String, dynamic> json)
    : messageId = json['messageId'],
      senderId = json['senderId'],
      text = json['text'],
      time = (json['time'] as Timestamp).toDate();

  @override
  // TODO: implement props
  List<Object?> get props => [messageId];
}
