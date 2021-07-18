import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thelawala/bloc_observer.dart';

import 'my_app.dart';
import 'amplifyconfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = TWBlocObserver();
  await _initAmplifyFlutter();
  runApp(MyApp());
}

Future<void> _initAmplifyFlutter() async {
  try {
    AmplifyAuthCognito auth = AmplifyAuthCognito();
    await Amplify.addPlugins([auth]);
    await Amplify.configure(amplifyconfig);
    print('Aws Configured');
  } on AmplifyAlreadyConfiguredException {
    print(
        "Amplify was already configured. Looks like app restarted on android.");
  }
}