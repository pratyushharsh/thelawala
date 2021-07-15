part of 'register_bloc.dart';

enum RegisterStatus {
  INITIAL,
  LOADING,
  OTP_VERIFICATION_STARTED,
  VERIFYING_OTP,
  SUCCESS,
  FAILURE
}

class RegisterState extends Equatable {
  final String fullname;
  final String email;
  final String password;
  final String phone;
  final RegisterStatus status;
  final String error;

  RegisterState(
      {required this.fullname,
      required this.email,
      required this.password,
      required this.phone,
      required this.status,
      required this.error});

  RegisterState copyWith(
      {String? fullname,
      String? email,
      String? password,
      String? phone,
      RegisterStatus? status,
      String? error}) {
    return RegisterState(
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [fullname, email, error, password, phone, status];
}
