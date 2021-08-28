part of 'login_bloc.dart';

enum LoginStatus {
  INITIAL,
  LOGIN_WAITING,
  LOGIN_FAILED,
  LOGIN_SUCCESS,
  LOGIN_USER_NOT_CONFIRM
}

class LoginState {
  final String username;
  final String password;
  final LoginStatus status;
  final String errorMessage;

  bool get isValid {
    return this.username.isNotEmpty && this.password.isNotEmpty;
  }

  LoginState(
      {required this.username,
      required this.password,
      required this.status,
      required this.errorMessage});

  LoginState copyWith(
      {String? username,
      String? password,
      LoginStatus? status,
      String? errorMessage}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
