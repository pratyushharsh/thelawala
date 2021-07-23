import 'package:flutter/material.dart';
import 'package:thelawala/config/routes/route_config.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {
          Navigator.of(context).pushNamed(RouteConfig.ADD_NEW_PRODUCT);
        },
        child: Text("Add New Item"),),
      ),
    );
  }
}
