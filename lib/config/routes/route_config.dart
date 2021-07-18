import 'package:flutter/material.dart';
import 'package:thelawala/core/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:thelawala/core/auth/login/screen/login.dart';
import 'package:thelawala/core/auth/login/screen/login_email_screen.dart';
import 'package:thelawala/core/auth/register/screen/otp_verification_screen.dart';
import 'package:thelawala/core/auth/register/screen/register_screen.dart';
import 'package:thelawala/core/home/screen/home_screen.dart';
import 'package:thelawala/modules/dashboard/update-profile/update-profile.dart';

class RouteConfig {
  static const String HOME_PAGE = "/";
  static const String LOGIN_PAGE = "/login";
  static const String LOGIN_EMAIL_PAGE = "/login-email";
  static const String REGISTER_PAGE = "/register";
  static const String VERIFY_OTP_PAGE = "/verify-otp";
  static const String FORGOT_PASSWORD_PAGE = "/forgot-password";

  static const String UPDATE_USER_PROFILE = "/update-profile";


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LOGIN_PAGE:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case LOGIN_EMAIL_PAGE:
        return MaterialPageRoute(builder: (_) => LoginEmailScreen());
      case REGISTER_PAGE:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case FORGOT_PASSWORD_PAGE:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case VERIFY_OTP_PAGE:
        var username = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpVerificationScreen(username: username));
      case UPDATE_USER_PROFILE:
        return MaterialPageRoute(builder: (_) => UpdateUserProfile());
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
