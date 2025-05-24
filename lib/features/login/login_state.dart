import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading, autoValidate;
  final String? errMsg;

  const LoginState({
    this.isLoading = false,
    this.autoValidate = false,
    this.errMsg,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, autoValidate, errMsg];

  LoginState copyWith({bool? isLoading, bool? autoValidate, String? errMsg}) {
    return LoginState(
      isLoading: isLoading ?? false,
      autoValidate: autoValidate ?? false,
      errMsg: errMsg,
    );
  }
}
