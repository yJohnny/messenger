import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/registration/registration_state.dart';
import 'package:messenger/constants/extensions.dart';
import 'package:messenger/services/auth_service.dart';
import '../../di/di.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationState());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    safeEmit(state.copyWith(isLoading: true));

    try {
      await getIt.get<AuthService>().createAccount(
        email: email,
        password: password,
      );
      safeEmit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      safeEmit(state.copyWith(errMsg: e.message ?? 'Registration failed'));
    }
  }

  void switchToAutoValidate() {
    safeEmit(state.copyWith(autoValidate: true));
  }
}
