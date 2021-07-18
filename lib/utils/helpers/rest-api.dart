import 'dart:collection';
import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApiBuilder {
  final String baseUrl;

  RestApiBuilder(this.baseUrl);

  Future<String> getAuthToken() async {
    try {
      AuthSession token = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      if (token is CognitoAuthSession) {
        return 'Bearer ${token.userPoolTokens!.idToken}';
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future<Map<String, String>> buildAuthHeader() async {
    Map<String, String> map = {
      "Authorization": await getAuthToken(),
      "x-api-key": 'API_KEY',
      "Content-Type": "application/json"
    };
    return map;
  }

  // Response get({required RestOptions restOptions}) {
  //   http.get(url)
  // }
  //
  // Response post({required RestOptions restOptions}) {
  //   http.post(url)
  // }

  Response delete({required RestOptions restOptions}) {
    throw UnimplementedError('get has not been implemented.');
  }

  Response put({required RestOptions restOptions}) {
    throw UnimplementedError('get has not been implemented.');
  }
}

class RestOptions {
  String path;
  Uint8List? body;
  Map<String, String>? queryParameters;
  Map<String, String>? headers;

  RestOptions({
    required this.path,
    this.body,
    this.queryParameters,
    this.headers,
  });
}

class RestResponse {

}