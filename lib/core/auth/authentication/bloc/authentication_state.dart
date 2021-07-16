part of 'authentication_bloc.dart';


enum AuthenticationStatus { AUTHENTICATED, UNAUTHENTICATED, UNKNOWN }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;

  const AuthenticationState._({required this.status, required this.user});

  const AuthenticationState.unauthenticated()
      : this._(
      status: AuthenticationStatus.UNAUTHENTICATED,
      user: UserModel.empty);

  const AuthenticationState.authenticated(UserModel user)
      : this._(
      status: AuthenticationStatus.AUTHENTICATED,
      user: user);

  @override
  List<Object?> get props => [status, user];
}

