import '../../data/models/user/login_request.dart';
import '../../data/models/user/register_request.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequest request);
  Future<UserEntity> register(RegisterRequest request);
  Future<void> logout();
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
