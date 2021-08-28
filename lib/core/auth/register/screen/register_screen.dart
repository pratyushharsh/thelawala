import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/register/bloc/register_bloc.dart';
import 'package:thelawala/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            RegisterBloc(authRepo: RepositoryProvider.of(context)),
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "Sign up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                "Welcome Aboard",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20,),
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
    return BlocConsumer<RegisterBloc, RegisterState>(listener: (ctx, state) {
      if (RegisterStatus.LOADING == state.status) {
        _showAlert(ctx);
      } else if (RegisterStatus.OTP_VERIFICATION_STARTED == state.status) {
        Navigator.pop(ctx);
        Navigator.of(context)
            .pushNamed(RouteConfig.VERIFY_OTP_PAGE, arguments: state.email);
      } else if (RegisterStatus.FAILURE == state.status) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("${state.error}"),
        ));
      }
    }, builder: (context, state) {
      return Column(
        children: [
          CustomTextField(
            label: 'Full Name',
            initialValue: state.fullname,
            onValueChange: (val) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(UsernameChangeEvent(val));
            },
          ),
          CustomTextField(
            label: 'Email',
            initialValue: state.email,
            onValueChange: (val) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(EmailChangeEvent(val));
            },
          ),
          CustomTextField(
            label: 'Password',
            initialValue: state.password,
            onValueChange: (val) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(PasswordChangeEvent(val));
            },
          ),
          CustomTextField(
            label: 'Phone',
            initialValue: state.phone,
            onValueChange: (val) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(PhoneChangeEvent(val));
            },
          ),
          SizedBox(height: 20,),
          if (state.isValid)
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<RegisterBloc>(context).add(SubmitUser());
                    },
                    child: Text("Sign Up")),
              ),
            ],
          )
        ],
      );
    });
  }
}
