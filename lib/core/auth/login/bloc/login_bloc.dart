import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authRepo;
  final AuthenticationBloc authBloc;

  LoginBloc({required this.authRepo, required this.authBloc})
      : super(LoginState(
            username: '', password: '', status: LoginStatus.INITIAL, errorMessage: ''));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnUsernameChangeEvent) {
      yield state.copyWith(username: event.username);
    } else if (event is OnPasswordChangeEvent) {
      yield state.copyWith(password: event.password);
    } else if (event is ProceedLogin) {
      yield* _mapLogin();
    }
  }

  Stream<LoginState> _mapLogin() async* {
    try {
      yield state.copyWith(status: LoginStatus.LOGIN_WAITING);
      var loggedIn = await authRepo.logInWithEmailAndPassword(
          email: state.username, password: state.password);
      if (loggedIn) {
        yield state.copyWith(status: LoginStatus.LOGIN_SUCCESS);
        authBloc.signInIfSessionAvailable();
      } else {

      }
      yield state.copyWith(status: LoginStatus.LOGIN_SUCCESS);
    } on LogInWithEmailAndPasswordFailure catch(e) {
      yield state.copyWith(status: LoginStatus.LOGIN_FAILED, errorMessage: e.error);
    } catch (e) {
      print(e);
      yield state.copyWith(status: LoginStatus.LOGIN_FAILED);
    }
  }
}
