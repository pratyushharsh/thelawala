import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final String username;
  final AuthenticationRepository authRepo;

  OtpVerifyBloc(this.username, {required this.authRepo})
      : super(OtpVerifyState(
            username: username, otp: "", status: OTPVerifyStatus.INITIAL));

  @override
  Stream<OtpVerifyState> mapEventToState(
    OtpVerifyEvent event,
  ) async* {
    if (event is OnOtpChange) {
      yield state.copyWith(otp: event.otp);
    } else if (event is VerifyOtp) {
      yield* _mapSubmitOtp();
    }
  }

  Stream<OtpVerifyState> _mapSubmitOtp() async* {
    try {
      yield state.copyWith(status: OTPVerifyStatus.VERIFYING);
      await Future.delayed(Duration(seconds: 2));
      var response = await authRepo.submitVerificationCode(
          username: state.username, confirmationCode: state.otp);
      print(response);
      yield state.copyWith(status: OTPVerifyStatus.VERIFIED);
    } catch (e) {
      yield state.copyWith(status: OTPVerifyStatus.FAILURE);
    }
  }
}
