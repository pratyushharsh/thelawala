part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnUsernameChangeEvent extends LoginEvent {
  final String username;

  OnUsernameChangeEvent(this.username);
}

class OnPasswordChangeEvent extends LoginEvent {
  final String password;

  OnPasswordChangeEvent(this.password);
}

class ProceedLogin extends LoginEvent {}