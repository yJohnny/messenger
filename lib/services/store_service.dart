import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/models/message_model.dart';
import 'package:messenger/models/user_model.dart';
import '../di/di.dart';
import '../models/chat_model.dart';
import 'auth_service.dart';

class StoreService {
  final FirebaseFirestore fireStore;

  StoreService({required this.fireStore});

  //add new user auth information
  Future<void> setUser(Map<String, dynamic> userData) async {
    await fireStore
        .collection('users')
        .doc(userData['uid'])
        .set(userData, SetOptions(merge: true));
  }

  //users stream
  Stream<List<UserModel>> usersStream() {
    return fireStore
        .collection('users')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .where(
                    (user) =>
                        user['uid'] !=
                        getIt.get<AuthService>().currentUser?.uid,
                  )
                  .map((doc) => UserModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<String> getOrCreatePrivateChat(String uid1, String uid2) async {
    final members = [uid1, uid2]..sort();
    final chats =
        await fireStore
            .collection('chats')
            .where('members', isEqualTo: members)
            .limit(1)
            .get();

    if (chats.docs.isNotEmpty) {
      //already have chat
      return chats.docs.first.id;
    } else {
      //new chat
      final chatRef = fireStore.collection('chats').doc(); // заранее создаём id
      await chatRef.set({
        'chatId': chatRef.id,
        'members': members,
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
      return chatRef.id;
    }
  }

  Stream<List<ChatModel>> userChatsStreamTyped() {
    return fireStore
        .collection('chats')
        .where(
          'members',
          arrayContains: getIt.get<AuthService>().currentUser?.uid ?? 'id',
        )
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Stream<List<MessageModel>> messagesStreamTyped(String chatId) {
    return fireStore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => MessageModel.fromJson(doc.data()))
                  .toList(),
        );
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final messagesRef = fireStore
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    final messageDoc = messagesRef.doc();
    final now = Timestamp.now();

    await messageDoc.set({
      'messageId': messageDoc.id,
      'senderId': senderId,
      'text': text,
      'time': now,
    });

    await fireStore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': now,
    });
  }
}
