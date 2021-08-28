part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class OnUserNameChange extends ForgotPasswordEvent {
  final String username;

  OnUserNameChange(this.username);
}

class OnReceiveForgotPaswordCode extends ForgotPasswordEvent {}

class OnOtpChange extends ForgotPasswordEvent {
  final String otp;

  OnOtpChange(this.otp);
}

class OnPasswordChange extends ForgotPasswordEvent {
  final String password;

  OnPasswordChange(this.password);
}

class SubmitResetPassword extends ForgotPasswordEvent {}
