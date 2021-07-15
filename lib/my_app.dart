import 'package:thelawala/core/auth/authentication/repository/authentication_repository.dart';

import 'config/routes/route_config.dart';
import 'core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthenticationRepository()),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc()..add(InitialAuthEvent()),
        ),
      ], child: AppView()),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.AUTHENTICATED:
                _navigator?.pushNamedAndRemoveUntil(
                    RouteConfig.HOME_PAGE, (route) => false);
                break;
              case AuthenticationStatus.UNAUTHENTICATED:
                _navigator?.pushNamedAndRemoveUntil(
                    RouteConfig.LOGIN_PAGE, (route) => false);
                break;
              default:
                break;
            }
          },
          child: child
        );
      },
      onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
