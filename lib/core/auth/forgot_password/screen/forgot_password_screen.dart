import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thelawala/core/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:thelawala/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ForgotPasswordBloc(RepositoryProvider.of(ctx)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (ForgotPasswordStatus.SUCCESS == state.status) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    if (ForgotPasswordStatus.LOADING == state.status)
                      CircularProgressIndicator(),
                    if (ForgotPasswordStatus.INITIAL == state.status ||
                        ForgotPasswordStatus.USERNAME_INPUT == state.status)
                      CustomTextField(
                        label: 'Username',
                        onValueChange: (val) {
                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(OnUserNameChange(val));
                        },
                      ),
                    if (ForgotPasswordStatus.USERNAME_INPUT == state.status)
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Continue'),
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordBloc>(context)
                                .add(OnReceiveForgotPaswordCode());
                          },
                        ),
                      ),
                    if (ForgotPasswordStatus.AWAITING_USER_CODE ==
                            state.status ||
                        ForgotPasswordStatus.PASSWORD_INPUT == state.status)
                      EnterSignUpCode(),
                    if (state.isValidForPassword)
                      CustomTextField(
                        label: 'Password',
                        onValueChange: (val) {
                          BlocProvider.of<ForgotPasswordBloc>(context)
                              .add(OnPasswordChange(val));
                        },
                      ),
                    if (ForgotPasswordStatus.PASSWORD_INPUT == state.status &&
                        state.isValidForPassword)
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordBloc>(context)
                                .add(SubmitResetPassword());
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EnterSignUpCode extends StatelessWidget {
  const EnterSignUpCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Reset password code sent to your mail'),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              animationDuration: Duration(milliseconds: 300),
              onChanged: (value) {
                BlocProvider.of<ForgotPasswordBloc>(context)
                    .add(OnOtpChange(value));
              },
              onCompleted: (val) {},
              appContext: context,
            )
          ],
        );
      },
    );
  }
}
