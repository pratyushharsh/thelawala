import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/register/bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterBloc(authRepo: RepositoryProvider.of(context)),
        child: Container(
          margin: EdgeInsets.all(25),
          child: ListView(
            children: [
              Text(
                "Sign up",
                style: TextStyle(fontSize: 50),
              ),
              UserDetail()
            ],
          ),
        ),
      ),
    );
  }
}

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
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
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (ctx, state) {
      if (RegisterStatus.LOADING == state.status) {
        _showAlert(ctx);
      } else if (RegisterStatus.OTP_VERIFICATION_STARTED == state.status) {
        Navigator.pop(ctx);
        Navigator.of(context).pushNamed(RouteConfig.VERIFY_OTP_PAGE, arguments: state.email);
      } else if (RegisterStatus.FAILURE == state.status) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${state.error}"),
        ));
      }
    }, builder: (context, state) {
      return Column(
        children: [
          TextFormField(
            initialValue: state.fullname,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), labelText: "Name"),
            onChanged: (val) {
              BlocProvider.of<RegisterBloc>(context).add(UsernameChangeEvent(val));
            },
          ),
          TextFormField(
            initialValue: state.email,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email), labelText: "Email"),
            onChanged: (val) {
              BlocProvider.of<RegisterBloc>(context).add(EmailChangeEvent(val));
            },
          ),
          TextFormField(
            initialValue: state.password,
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock), labelText: "Password"),
            onChanged: (val) {
              BlocProvider.of<RegisterBloc>(context).add(PasswordChangeEvent(val));
            },
          ),
          TextFormField(
            initialValue: state.phone,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone), labelText: "Phone"),
            onChanged: (val) {
              BlocProvider.of<RegisterBloc>(context).add(PhoneChangeEvent(val));
            },
          ),
          TextButton(
              onPressed: () {
                BlocProvider.of<RegisterBloc>(context).add(SubmitUser());
              },
              child: Text("Sign Up"))
        ],
      );
    });
  }
}
