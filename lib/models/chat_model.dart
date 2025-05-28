import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable{
  final String chatId, lastMessage;
  final List<String> members;
  final DateTime? lastMessageTime;

  ChatModel.fromJson(Map<String, dynamic> json)
      : chatId = json['chatId'] ?? '',
        lastMessage = json['lastMessage'] ?? '',
        members = (json['members'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
        lastMessageTime =
        json['lastMessageTime'] != null
            ? (json['lastMessageTime'] as Timestamp).toDate()
            : null;

  @override
  // TODO: implement props
  List<Object?> get props => [chatId];
}