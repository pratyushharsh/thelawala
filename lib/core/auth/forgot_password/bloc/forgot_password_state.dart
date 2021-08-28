part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus {
  INITIAL,
  LOADING,
  USERNAME_INPUT,
  AWAITING_USER_CODE,
  PASSWORD_INPUT,
  SUCCESS,
  FAILURE
}

class ForgotPasswordState {
  final String username;
  final ForgotPasswordStatus status;
  final String authCode;
  final String password;

  ForgotPasswordState(
      {required this.username,
      required this.status,
      required this.authCode,
      required this.password});

  bool get isValidForPassword {
    return authCode.length == 6;
  }

  ForgotPasswordState copyWith(
      {String? username,
      ForgotPasswordStatus? status,
      String? authCode,
      String? password}) {
    return ForgotPasswordState(
        username: username ?? this.username,
        status: status ?? this.status,
        authCode: authCode ?? this.authCode,
        password: password ?? this.password);
  }
}
