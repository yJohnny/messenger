import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:messenger/router/router.dart';
import 'package:messenger/services/auth_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  firebaseAuth.authStateChanges().listen((user) {
    router.refresh();
  });
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(firebaseAuth: firebaseAuth),
  );
}
