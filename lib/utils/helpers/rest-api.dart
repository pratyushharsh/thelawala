import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApiBuilder {
  final String baseUrl;

  RestApiBuilder(this.baseUrl);

  Future<CognitoAuthSession> getCurrentSession() async {
    try {
      AuthSession token = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true));
      if (token is CognitoAuthSession) {
        return token;
      } else {
        throw 'Not a valid session';
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

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

  Future<Map<String, String>> buildAuthHeader(CognitoAuthSession session) async {
    Map<String, String> map = {
      "Authorization": session.userPoolTokens!.idToken,
      "x-api-key": 'API_KEY',
      "Content-Type": "application/json"
    };
    return map;
  }

  Future<Response> get({required RestOptions restOptions}) async {
    CognitoAuthSession session = await getCurrentSession();
    Map<String, String> auth = await buildAuthHeader(session);
    Map<String, String> header = new HashMap.from(auth);
    var _url = Uri.parse(baseUrl + '/vendor/${session.userSub}' + restOptions.path);
    print('************************');
    print(header);
    print('************************');
    final response =
    await http.get(_url, headers: header);
    var parsed = json.decode(response.body);
    print(parsed);
    return response;
  }

  Future<Response> post({required RestOptions restOptions}) async {
    CognitoAuthSession session = await getCurrentSession();
    Map<String, String> auth = await buildAuthHeader(session);
    Map<String, String> header = new HashMap.from(auth);
    var _url = Uri.parse(baseUrl + '/vendor/${session.userSub}' + restOptions.path);
    final response =
      await http.post(_url, headers: header, body: restOptions.body);
    var parsed = json.decode(response.body);
    print(parsed);
    return response;
  }

  Response delete({required RestOptions restOptions}) {
    throw UnimplementedError('get has not been implemented.');
  }

  Response put({required RestOptions restOptions}) {
    throw UnimplementedError('get has not been implemented.');
  }

  dynamic parsedResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        var res = ApiExceptionMessage.fromJson(json.decode(response.body));
        throw FetchDataException(res.message);
    }
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message)
      : super(message, "Error during communication: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String message)
      : super(message, "Unauthorised: ");
}

class BadRequestException extends AppException {
  BadRequestException(String message)
      : super(message, "Invalid Request: ");
}

class RestOptions {
  String path;
  String? body;
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

class ApiExceptionMessage {
  late final String timestamp;
  late final String message;

  ApiExceptionMessage({required this.timestamp, required this.message});

  ApiExceptionMessage.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    return data;
  }
}