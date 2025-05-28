import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger/services/fcm_service.dart';
import 'package:messenger/services/store_service.dart';
import '../di/di.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        await addToUserCollections(newUser: userCredential.user!);
      }

      return userCredential;
    } catch (_) {
      return null;
    }
  }

  Future<void> addToUserCollections({
    required User newUser,
    String? regName,
  }) async {
    final fcmToken = await getIt.get<FCMService>().getToken();

    await getIt.get<StoreService>().setUser({
      'uid': newUser.uid,
      'name': regName ?? newUser.displayName ?? '',
      'email': newUser.email ?? '',
      'fcmToken': fcmToken ?? '',
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
