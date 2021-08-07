import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/core/auth/authentication/bloc/authentication_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView(
          children: [
            SizedBox(height: 50,),

            OutlinedButton(onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(SignOutUser());
            }, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
