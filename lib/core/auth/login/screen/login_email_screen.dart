import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/login/bloc/login_bloc.dart';
import 'package:thelawala/widgets/custom_text_field.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => LoginBloc(
            authRepo: RepositoryProvider.of(context),
            authBloc: BlocProvider.of(context),
          homeBloc: BlocProvider.of(context)
        ),
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
    return SingleChildScrollView(
      child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (LoginStatus.LOGIN_WAITING == state.status) {
          _showAlert(context);
        } else if (LoginStatus.LOGIN_SUCCESS == state.status) {
          Navigator.pop(context);
        } else if (LoginStatus.LOGIN_FAILED == state.status) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${state.errorMessage}"),
          ));
        } else if (LoginStatus.LOGIN_USER_NOT_CONFIRM == state.status) {
          Navigator.of(context).pushNamed(RouteConfig.VERIFY_OTP_PAGE, arguments: state.username);
        }
      }, builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Sign in to your account.',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                label: 'Email',
                initialValue: state.username,
                onValueChange: (val) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(OnUsernameChangeEvent(val));
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                label: 'Password',
                initialValue: state.password,
                obscureText: true,
                onValueChange: (val) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(OnPasswordChangeEvent(val));
                },
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(RouteConfig.FORGOT_PASSWORD_PAGE);
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              if (state.isValid)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<LoginBloc>(context)
                              .add(ProceedLogin());
                        },
                        child: Container(
                            padding: EdgeInsets.all(12), child: Text("Login")),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: 'Dono\'t have an account? ',
                      style: TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .popAndPushNamed(RouteConfig.REGISTER_PAGE);
                              }),
                      ]),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
