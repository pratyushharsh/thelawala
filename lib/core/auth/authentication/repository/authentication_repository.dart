import 'dart:async';
import 'dart:collection';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class SignUpFailure implements Exception {
  final String message;

  SignUpFailure(this.message);
}

class UserNotConfirmFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {
  final String error;

  LogInWithEmailAndPasswordFailure(this.error);
}

class LogInWithGoogleFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  Future<SignUpResult> signUp({
    required String password,
    required String email,
    required String phone,
    required String name
  }) async {
    try {
      Map<String, String> attrib = HashMap();
      attrib.putIfAbsent("email", () => email);
      attrib.putIfAbsent("phone_number", () => phone);
      attrib.putIfAbsent("name", () => name);
      var result = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: attrib));
      return result;
    } on AuthException catch(e) {
      throw SignUpFailure(e.message);
    } catch (e) {
      print(e);
      throw SignUpFailure('');
    }
  }

  Future<SignUpResult> submitVerificationCode({
    required String username,
    required String confirmationCode,
  }) async {
    assert(username != null && confirmationCode != null);
    try {
      var result = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);
      print(result.isSignUpComplete);
      print(result.nextStep);
      return result;
    } on CodeMismatchException catch (e) {
      throw e;
    } catch (e) {
      print(e);
      throw SignUpFailure('');
    }
  }

  Future<bool> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var res = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      return res.isSignedIn;
    } on UserNotConfirmedException {
      throw UserNotConfirmFailure();
    } on AuthException catch (e) {
      print(e);
      throw LogInWithEmailAndPasswordFailure(e.message);
    }
  }
}