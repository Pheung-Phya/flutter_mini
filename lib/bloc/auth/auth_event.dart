part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class LoginRequested extends AuthEvent {
  final LoginRequest request;

  const LoginRequested(this.request);

  @override
  List<Object?> get props => [request];
}

final class RegisterRequested extends AuthEvent {
  final RegisterRequest request;

  const RegisterRequested(this.request);

  @override
  List<Object?> get props => [request];
}

final class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  @override
  List<Object?> get props => [];
}

class OtpVerifyRequested extends AuthEvent {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;
  final String otpCode;

  const OtpVerifyRequested({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
    required this.otpCode,
  });

  @override
  List<Object> get props => [
    email,
    name,
    password,
    passwordConfirmation,
    otpCode,
  ];
}
