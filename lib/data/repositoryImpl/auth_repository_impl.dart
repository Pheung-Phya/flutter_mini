import 'package:flutter_mini/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_mini/data/models/login_request.dart';
import 'package:flutter_mini/data/models/register_request.dart';
import 'package:flutter_mini/data/models/user_model.dart';
import 'package:flutter_mini/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> login(LoginRequest request) {
    return remoteDataSource.login(request);
  }

  @override
  Future<UserModel> register(RegisterRequest request) {
    return remoteDataSource.register(request);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
}
