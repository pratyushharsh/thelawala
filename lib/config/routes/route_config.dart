import 'package:flutter/material.dart';
import 'package:thelawala/core/auth/forgot_password/screen/forgot_password_screen.dart';
import 'package:thelawala/core/auth/login/screen/login.dart';
import 'package:thelawala/core/auth/login/screen/login_email_screen.dart';
import 'package:thelawala/core/auth/register/screen/otp_verification_screen.dart';
import 'package:thelawala/core/auth/register/screen/register_screen.dart';
import 'package:thelawala/core/home/screen/home_screen.dart';
import 'package:thelawala/models/response/category-response.dart';
import 'package:thelawala/modules/category/add_new_category.dart';
import 'package:thelawala/modules/category/category_screen.dart';
import 'package:thelawala/modules/dashboard/update-profile/update-profile.dart';
import 'package:thelawala/modules/menu/add_menu_item_screen.dart';
import 'package:thelawala/modules/menu/item_modifier.dart';
import 'package:thelawala/modules/menu/menu_screen.dart';

class RouteConfig {
  static const String SPLASH_SCREEN = "/";
  static const String HOME_PAGE = "/home";
  static const String LOGIN_PAGE = "/login";
  static const String LOGIN_EMAIL_PAGE = "/login-email";
  static const String REGISTER_PAGE = "/register";
  static const String VERIFY_OTP_PAGE = "/verify-otp";
  static const String FORGOT_PASSWORD_PAGE = "/forgot-password";
  static const String UPDATE_USER_PROFILE = "/update-profile";

  static const String MENU_SCREEN = '/menu-screen';
  static const String ADD_NEW_PRODUCT = '/add-menu-item';
  static const String NEW_ITEM_MODIFIER = '/new-item-modifier';

  static const String ADD_NEW_CATEGORY = '/add-new-category';
  static const String CATEGORY_PAGE = '/category';

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
      case ADD_NEW_PRODUCT:
        return MaterialPageRoute(builder: (_) => AddMenuItemScreen());
      case NEW_ITEM_MODIFIER:
        return MaterialPageRoute(builder: (_) => NewItemModifier());
      case ADD_NEW_CATEGORY:
        return MaterialPageRoute(builder: (_) => AddNewCategory());
      case CATEGORY_PAGE:
        return MaterialPageRoute(builder: (_) => CategoryScreen());
      case MENU_SCREEN:
        var cat = settings.arguments as CategoryResponse;
        return MaterialPageRoute(builder: (_) => MenuScreen(category: cat,));
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
