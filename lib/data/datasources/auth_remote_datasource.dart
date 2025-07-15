import 'dart:developer';
import 'dart:convert';

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
    final response = await apiClient.client.post(
      '/register',
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data); // ✅
  }

  Future<void> logout() async {
    await apiClient.client.post('/logout');
  }

  Future<void> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    final response = await apiClient.client.post(
      '/verify-otp', // Make sure this matches your backend route
      data: {'email': email, 'otp_code': otpCode},
    );

    // Handle response status or errors
    if (response.statusCode != 200) {
      throw Exception(response.data['message'] ?? 'OTP verification failed');
    }
  }
}
