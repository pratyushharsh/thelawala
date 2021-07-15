import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authRepo;

  RegisterBloc({required this.authRepo})
      : super(RegisterState(
            email: "",
            password: "",
            phone: "+91",
            fullname: "",
            status: RegisterStatus.INITIAL,
            error: ''));

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is UsernameChangeEvent) {
      yield state.copyWith(fullname: event.value);
    } else if (event is PasswordChangeEvent) {
      yield state.copyWith(password: event.value);
    } else if (event is PhoneChangeEvent) {
      yield state.copyWith(phone: event.value);
    } else if (event is EmailChangeEvent) {
      yield state.copyWith(email: event.value);
    } else if (event is SubmitUser) {
      yield* _mapOnUserSignUp(state);
    }
  }

  Stream<RegisterState> _mapOnUserSignUp(RegisterState state) async* {
    try {
      yield state.copyWith(status: RegisterStatus.LOADING);
      print(state);
      // await Future.delayed(Duration(seconds: 2));
      var response = await authRepo.signUp(
          password: state.password,
          email: state.email,
          phone: state.phone,
          name: state.fullname);
      print(response);
      yield state.copyWith(status: RegisterStatus.OTP_VERIFICATION_STARTED);
    } on SignUpFailure catch (e) {
      yield state.copyWith(status: RegisterStatus.FAILURE, error: e.message);
    }
  }
}
