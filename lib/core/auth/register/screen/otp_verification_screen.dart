import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/register/bloc/otp_verify_bloc.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String username;

  const OtpVerificationScreen({Key? key, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => OtpVerifyBloc(username, authRepo: RepositoryProvider.of(context)),
      child: OtpVerification(),
    );
  }
}

class OtpVerification extends StatelessWidget {
  const OtpVerification({Key? key}) : super(key: key);

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
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
          listener: (context, state) {
            if (state.status == OTPVerifyStatus.VERIFYING) {
              _showAlert(context);
            } else if (state.status == OTPVerifyStatus.VERIFIED) {
              Navigator.pushReplacementNamed(context, RouteConfig.LOGIN_PAGE);
            }
          },
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.all(40),
              child: Column(
                children: [
                  Center(
                    child: Text("Check your mail for signup code"),
                  ),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    animationDuration: Duration(milliseconds: 300),
                    onChanged: (value) {

                    },
                    onCompleted: (val) {
                      BlocProvider.of<OtpVerifyBloc>(context).add(OnOtpChange(val));
                    },
                    appContext: context,
                  ),
                  // TextFormField(
                  //   initialValue: state.otp,
                  //   decoration: InputDecoration(
                  //       prefixIcon: Icon(Icons.phone), labelText: "Phone"),
                  //   onChanged: (val) {
                  //     BlocProvider.of<OtpVerifyBloc>(context).add(OnOtpChange(val));
                  //   },
                  // ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                      text: TextSpan(
                          text: 'Did not receive OTP? ',
                          style: TextStyle(color: Colors.black87),
                          children: [
                            TextSpan(
                                text: 'Resend OTP',
                                style:
                                TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    BlocProvider.of<OtpVerifyBloc>(context).add(ResendSignUpCode());
                                  }),
                          ]),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<OtpVerifyBloc>(context).add(VerifyOtp());
                        },
                        child: Text("Verify")),
                  )
                ],
              ),
            );
          },
        ));
  }
}
