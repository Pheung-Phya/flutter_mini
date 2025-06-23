import 'package:flutter_mini/data/models/login_request.dart';
import 'package:flutter_mini/data/models/register_request.dart';
import 'package:flutter_mini/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<UserModel> register(RegisterRequest request);
  Future<void> logout();
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
