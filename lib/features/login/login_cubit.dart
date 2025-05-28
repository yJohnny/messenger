import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/utils/extensions.dart';
import 'package:messenger/features/login/login_state.dart';
import '../../di/di.dart';
import '../../services/auth_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> login({required String email, required String password}) async {
    safeEmit(state.copyWith(isLoading: true));

    try {
      await getIt.get<AuthService>().signIn(email: email, password: password);
      safeEmit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      safeEmit(state.copyWith(errMsg: e.message ?? 'Login failed'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await getIt.get<AuthService>().signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      safeEmit(state.copyWith(errMsg: e.message ?? 'Sign In failed'));
    }
  }

  void switchToAutoValidate() {
    safeEmit(state.copyWith(autoValidate: true));
  }
}
