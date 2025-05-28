import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  final FirebaseMessaging firebaseMessaging;

  FCMService({required this.firebaseMessaging});

  Future<String?> getToken() async {
    try {
      String? token = await firebaseMessaging.getToken();
      return token;
    } catch (e) {
      return null;
    }
  }

  Future<bool> requestNotificationPermissions() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      final firebaseToken = await getToken();
      print('firebaseToken: $firebaseToken');
      return true;
    } else {
      return false;
    }
  }

  void setupNotificationHandlers(Function(RemoteMessage) onMessageHandler) {
    FirebaseMessaging.onMessage.listen(onMessageHandler);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print('Background message: ${message.messageId}');
  }
}
