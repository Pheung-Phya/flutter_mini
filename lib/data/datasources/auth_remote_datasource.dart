import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/user/login_request.dart';
import '../models/user/register_request.dart';
import '../models/user/user_model.dart';
import '../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<UserModel> login(LoginRequest request) async {
    final response = await apiClient.client.post(
      '/login',
      data: request.toJson(),
    );

    log(jsonEncode(response.data)); // ✅

    if (!response.data.containsKey('user')) {
      throw Exception(response.data['message'] ?? 'Unexpected error');
    }

    return UserModel.fromJson(
      response.data,
    ); // ✅ make sure you're using fromResponse to get token too
  }

  Future<UserModel> register(RegisterRequest request) async {
    try {
      log('===========================${request.toJson()}');

      final response = await apiClient.client.post(
        '/register',
        data: request.toJson(),
      );

      log('[register success] ${response.data}');
      return UserModel.empty();
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        // Laravel validation error
        final errors = e.response?.data['errors'];
        log('[register failed] Validation errors: $errors');

        // Optionally: show the first error message
        throw Exception(errors.values.first[0]);
      } else {
        log('[register failed] DioException: ${e.message}');
        throw Exception('Something went wrong: ${e.message}');
      }
    } catch (e) {
      log('[register failed] Unknown error: $e');
      throw Exception('Unexpected error occurred');
    }
  }

  Future<void> logout() async {
    await apiClient.client.post('/logout');
  }

  Future<void> verifyOtp({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
    required String otpCode,
  }) async {
    final payload = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'otp': otpCode,
    };
    log('payload : $payload');

    try {
      final response = await apiClient.client.post(
        '/verify-otp', // make sure slash here
        data: payload,
      );

      log('[verifyOtp success] ${response.data}');
    } on DioException catch (e) {
      final errorData = e.response?.data;
      log('[verifyOtp failed] ${errorData}');

      if (e.response?.statusCode == 422) {
        final errors = errorData?['errors'];
        if (errors != null) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            throw Exception(firstError[0]);
          } else if (firstError is String) {
            throw Exception(firstError);
          } else {
            throw Exception('Validation failed');
          }
        } else {
          throw Exception('Validation failed');
        }
      } else {
        throw Exception(errorData?['message'] ?? 'OTP verification failed');
      }
    }
  }
}
