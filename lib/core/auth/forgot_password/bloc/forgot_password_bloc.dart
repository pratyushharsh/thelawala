import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final log = Logger('ForgotPasswordBloc');

  final AuthenticationRepository authRepo;

  ForgotPasswordBloc(this.authRepo)
      : super(
          ForgotPasswordState(
              username: '',
              status: ForgotPasswordStatus.INITIAL,
              authCode: '',
              password: ''),
        );

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is OnUserNameChange) {
      yield state.copyWith(
          username: event.username,
          status: ForgotPasswordStatus.USERNAME_INPUT);
    } else if (event is OnReceiveForgotPaswordCode) {
      yield* _mapForgotPasswordCode(state);
    } else if (event is OnOtpChange) {
      yield state.copyWith(
          authCode: event.otp, status: ForgotPasswordStatus.AWAITING_USER_CODE);
    } else if (event is OnPasswordChange) {
      yield state.copyWith(
          password: event.password,
          status: ForgotPasswordStatus.PASSWORD_INPUT);
    } else if (event is SubmitResetPassword) {
      yield* _mapSubmitResetPassword(state);
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordCode(
      ForgotPasswordState state) async* {
    try {
      yield state.copyWith(status: ForgotPasswordStatus.LOADING);
      await authRepo.resetPassword(username: state.username);
      yield state.copyWith(status: ForgotPasswordStatus.AWAITING_USER_CODE);
    } catch (e) {
      log.severe(e);
    }
  }

  Stream<ForgotPasswordState> _mapSubmitResetPassword(
      ForgotPasswordState state) async* {
    try {
      yield state.copyWith(status: ForgotPasswordStatus.LOADING);
      await authRepo.confirmPassword(
          username: state.username,
          password: state.password,
          confirmationCode: state.authCode);
      yield state.copyWith(status: ForgotPasswordStatus.SUCCESS);
    } catch (e) {
      log.severe(e);
      yield state.copyWith(status: ForgotPasswordStatus.FAILURE);
    }
  }
}
