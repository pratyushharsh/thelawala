import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:thelawala/core/auth/authentication/model/model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState.unauthenticated()) {
    signInIfSessionAvailable();
  }

  signInIfSessionAvailable() async {
    print('Getting if user already present');
    // final session = await Amplify.Auth.fetchAuthSession();
    // if (session.isSignedIn) {
    //   print('User Alreadu Present');
    // }
    // try {
    //   CognitoAuthSession res = await Amplify.Auth.fetchAuthSession(
    //       options: CognitoSessionOptions(getAWSCredentials: true));
    //   print(res.userSub);
    //   print(res.identityId);
    // } on AmplifyException catch (e) {
    //
    //   print(e);
    // }
    try {
      var res = await Amplify.Auth.getCurrentUser();
      print(res);
      List<AuthUserAttribute> attr = await Amplify.Auth.fetchUserAttributes();
      // User usr = User(
      //     id: res.userId,
      //     email: res.username
      // );
      UserModel user = UserModel(userId: res.userId, name: res.username);
      add(AuthenticationUserChanged(user));
      print(res.userId);
      print('Current User Name = ' + res.username);
    } on AmplifyException catch (e) {
      print(e);
    }
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is InitialAuthEvent) {
      yield state;
    } else if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    }
  }

  mapOtherUserProperties(List<AuthUserAttribute> attr, ) {

    var phone;
    var name;

    attr.forEach((e) {
      if (e.userAttributeKey == 'phone_number') {
        phone  = e.value;
      }
    });

    attr.forEach((e) {
      if (e.userAttributeKey == 'name') {
        name  = e.value;
      }
    });
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event,
      ) {
    return event.user != UserModel.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }
}
