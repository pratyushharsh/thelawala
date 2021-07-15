import 'package:flutter/material.dart';
import 'package:thelawala/config/routes/route_config.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(
        children: [
          Text("Login With Email"),
          TextButton(onPressed: () {
            Navigator.of(context).pushNamed(RouteConfig.FORGOT_PASSWORD_PAGE);
          }, child: Text("Forgot Password"))
        ],
      ),),
    );
  }
}
