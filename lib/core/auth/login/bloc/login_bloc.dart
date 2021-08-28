import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';
import 'package:thelawala/core/home/screen/bloc/home_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authRepo;
  final AuthenticationBloc authBloc;
  final HomeBloc homeBloc;

  LoginBloc({required this.authRepo, required this.authBloc, required this.homeBloc})
      : super(LoginState(
            username: '', password: '', status: LoginStatus.INITIAL, errorMessage: ''));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnUsernameChangeEvent) {
      yield state.copyWith(username: event.username, status: LoginStatus.INITIAL);
    } else if (event is OnPasswordChangeEvent) {
      yield state.copyWith(password: event.password, status: LoginStatus.INITIAL);
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
        authBloc.signInIfSessionAvailable().then((value) => homeBloc.add(GetUserProfile()));
      } else {

      }
      yield state.copyWith(status: LoginStatus.LOGIN_SUCCESS);
    } on LogInWithEmailAndPasswordFailure catch(e) {
      yield state.copyWith(status: LoginStatus.LOGIN_FAILED, errorMessage: e.error);
    } on UserNotConfirmFailure {
      yield state.copyWith(status: LoginStatus.LOGIN_USER_NOT_CONFIRM);
    }
    catch (e) {
      print(e);
      yield state.copyWith(status: LoginStatus.LOGIN_FAILED);
    }
  }
}
