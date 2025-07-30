import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user/login_request.dart';
import '../models/user/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login(LoginRequest request) async {
    final userModel = await remoteDataSource.login(request);
    return userModel;
  }

  @override
  Future<UserEntity> register(RegisterRequest request) async {
    final userModel = await remoteDataSource.register(request);
    return userModel;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // Implement as needed
  }

  @override
  @override
  Future<void> verifyOtp({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
    required String otpCode,
  }) async {
    return await remoteDataSource.verifyOtp(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: passwordConfirmation,
      otpCode: otpCode,
    );
  }
}
