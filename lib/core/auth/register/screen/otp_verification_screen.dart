import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/config/routes/route_config.dart';
import 'package:thelawala/core/auth/register/bloc/otp_verify_bloc.dart';
import 'package:thelawala/core/auth/register/bloc/register_bloc.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String username;

  const OtpVerificationScreen({Key? key, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
            return Column(
              children: [
                Center(
                  child: Text("OTP Verification"),
                ),
                TextFormField(
                  initialValue: state.otp,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone), labelText: "Phone"),
                  onChanged: (val) {
                    BlocProvider.of<OtpVerifyBloc>(context).add(OnOtpChange(val));
                  },
                ),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<OtpVerifyBloc>(context).add(VerifyOtp());
                    },
                    child: Text("Verify"))
              ],
            );
          },
        ));
  }
}
