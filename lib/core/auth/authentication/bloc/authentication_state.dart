part of 'authentication_bloc.dart';


enum AuthenticationStatus { AUTHENTICATED, UNAUTHENTICATED, UNKNOWN }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel employee;

  const AuthenticationState._({required this.status, required this.employee});

  const AuthenticationState.unauthenticated()
      : this._(
      status: AuthenticationStatus.UNAUTHENTICATED,
      employee: UserModel.empty);

  const AuthenticationState.authenticated()
      : this._(
      status: AuthenticationStatus.AUTHENTICATED,
      employee: UserModel.empty);

  @override
  List<Object?> get props => [status, employee];
}

