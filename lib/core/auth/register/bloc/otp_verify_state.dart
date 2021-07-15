part of 'otp_verify_bloc.dart';

enum OTPVerifyStatus { INITIAL, VERIFYING, VERIFIED, FAILURE }

class OtpVerifyState {
  final String username;
  final String otp;
  final OTPVerifyStatus status;

  OtpVerifyState(
      {required this.username, required this.otp, required this.status});

  OtpVerifyState copyWith({String? otp, OTPVerifyStatus? status}) {
    return OtpVerifyState(
      username: this.username,
      otp: otp ?? this.otp,
      status: status ?? this.status
    );
  }
}
