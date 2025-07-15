// auth_state.dart

part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserEntity user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class LoginFailure extends AuthState {
  final String message;

  const LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class RegisterSuccess extends AuthState {
  final UserEntity user;

  const RegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class RegisterFailure extends AuthState {
  final String message;

  const RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {
  final String message;

  const LogoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class OtpVerificationLoading extends AuthState {}

final class OtpVerificationSuccess extends AuthState {}

final class OtpVerificationFailure extends AuthState {
  final String error;

  const OtpVerificationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
