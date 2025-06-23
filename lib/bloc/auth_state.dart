part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// Initial state
final class AuthInitial extends AuthState {}

// Common loading state
final class AuthLoading extends AuthState {}

// Login States
final class LoginSuccess extends AuthState {
  final User user;

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

// Register States
final class RegisterSuccess extends AuthState {
  final User user;

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

// Logout States
final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {
  final String message;

  const LogoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Change Password States
final class ChangePasswordSuccess extends AuthState {
  final String message;

  const ChangePasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class ChangePasswordFailure extends AuthState {
  final String message;

  const ChangePasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
