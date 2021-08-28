part of 'otp_verify_bloc.dart';

@immutable
abstract class OtpVerifyEvent {}

class OnOtpChange extends OtpVerifyEvent {
  final String otp;

  OnOtpChange(this.otp);
}

class VerifyOtp extends OtpVerifyEvent {}

class ResendSignUpCode extends OtpVerifyEvent {}