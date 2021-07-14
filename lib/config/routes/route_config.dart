import 'package:flutter/material.dart';

class RouteConfig {
  static const String HOME_PAGE = "/";
  static const String LOGIN_PAGE = "/login";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_PAGE:
      case LOGIN_PAGE:
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
