import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_mini/core/storage/token_storage.dart';
import '../../data/models/user/login_request.dart';
import '../../data/models/user/register_request.dart';
import '../../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/otp_verify_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final OtpVerifyUseCase otpVerifyUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.otpVerifyUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<OtpVerifyRequested>(_onOtpVerifyRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(event.request);
      if (user.token != null) {
        await TokenStorage.saveToken(user.token!);
      } else {
        log('❌ Token is null!');
      }
      emit(LoginSuccess(user));
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(event.request);
      emit(RegisterSuccess(user));
    } catch (e) {
      log(e.toString());
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> _onOtpVerifyRequested(
    OtpVerifyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(OtpVerificationLoading());
    try {
      await otpVerifyUseCase(
        name: event.name,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
        email: event.email,
        otpCode: event.otpCode,
      );
      emit(OtpVerificationSuccess());
    } catch (e) {
      log(e.toString());
      emit(OtpVerificationFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await logoutUseCase();
      await TokenStorage.deleteToken();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutFailure(e.toString()));
    }
  }
}
