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
}
