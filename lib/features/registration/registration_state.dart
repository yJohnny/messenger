import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  final bool isLoading, autoValidate;
  final String? errMsg;

  const RegistrationState({
    this.isLoading = false,
    this.autoValidate = false,
    this.errMsg,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, autoValidate, errMsg];

  RegistrationState copyWith({
    bool? isLoading,
    bool? autoValidate,
    String? errMsg,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? false,
      autoValidate: autoValidate ?? false,
      errMsg: errMsg,
    );
  }
}
