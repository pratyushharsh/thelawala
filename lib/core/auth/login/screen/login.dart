import 'package:flutter/material.dart';
import 'package:thelawala/config/routes/route_config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Login Screen"),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteConfig.LOGIN_EMAIL_PAGE);
              },
              child: Text("Login With Email"),
            ),
            TextButton(onPressed: () {
              Navigator.of(context).pushNamed(RouteConfig.REGISTER_PAGE);
            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
