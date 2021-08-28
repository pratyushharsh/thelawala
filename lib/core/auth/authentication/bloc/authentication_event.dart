part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitialAuthEvent extends AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  final UserModel user;

  AuthenticationUserChanged(this.user);
}

class SignOutUser extends AuthenticationEvent {}

class ResendSignUpCode extends AuthenticationEvent {}