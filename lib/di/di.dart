import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger/router/router.dart';
import 'package:messenger/services/auth_service.dart';
import 'package:messenger/services/fcm_service.dart';
import 'package:messenger/services/store_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  firebaseAuth.authStateChanges().listen((user) {
    router.refresh();
  });

  getIt.registerLazySingleton<StoreService>(
    () => StoreService(fireStore: fireStore),
  );

  getIt.registerLazySingleton<AuthService>(
    () => AuthService(firebaseAuth: firebaseAuth),
  );
  getIt.registerLazySingleton<FCMService>(
    () => FCMService(firebaseMessaging: firebaseMessaging),
  );
}
