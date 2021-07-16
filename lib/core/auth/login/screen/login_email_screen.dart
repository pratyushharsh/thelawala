import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/login/bloc/login_bloc.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => LoginBloc(
            authRepo: RepositoryProvider.of(context),
            authBloc: BlocProvider.of(context)),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        children: [
          Container(height: 100, width: 100, child: CircularProgressIndicator())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (LoginStatus.LOGIN_WAITING == state.status) {
        _showAlert(context);
      } else if (LoginStatus.LOGIN_SUCCESS == state.status) {
        Navigator.pop(context);
      } else if (LoginStatus.LOGIN_FAILED == state.status) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${state.errorMessage}"),
        ));
      }
    }, builder: (context, state) {
      return Center(
        child: Column(
          children: [
            Text("Username"),
            TextFormField(
              initialValue: state.username,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: "Email"),
              onChanged: (val) {
                BlocProvider.of<LoginBloc>(context)
                    .add(OnUsernameChangeEvent(val));
              },
            ),
            TextFormField(
              initialValue: state.password,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), labelText: "Password"),
              onChanged: (val) {
                BlocProvider.of<LoginBloc>(context)
                    .add(OnPasswordChangeEvent(val));
              },
            ),
            TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  BlocProvider.of<LoginBloc>(context).add(ProceedLogin());
                },
                child: Text("Login")),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteConfig.FORGOT_PASSWORD_PAGE);
                },
                child: Text("Forgot Password")),
          ],
        ),
      );
    });
  }
}
