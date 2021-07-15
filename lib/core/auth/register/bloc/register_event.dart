part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class UsernameChangeEvent extends RegisterEvent {
  final String value;

  UsernameChangeEvent(this.value);
}

class PasswordChangeEvent extends RegisterEvent {
  final String value;

  PasswordChangeEvent(this.value);
}

class EmailChangeEvent extends RegisterEvent {
  final String value;

  EmailChangeEvent(this.value);
}

class PhoneChangeEvent extends RegisterEvent {
  final String value;

  PhoneChangeEvent(this.value);
}

class SubmitUser extends RegisterEvent {}
