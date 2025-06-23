import 'package:dio/dio.dart';
import 'package:flutter_mini/data/models/login_request.dart';
import 'package:flutter_mini/data/models/register_request.dart';
import 'package:flutter_mini/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<UserModel> register(RegisterRequest request) async {
    final response = await dio.post('/register', data: request.toJson());

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data['user']);
    } else {
      throw Exception('Register failed');
    }
  }

  Future<UserModel> login(LoginRequest request) async {
    final response = await dio.post('/login', data: request.toJson());

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data['user']);
    } else {
      throw Exception('Register failed');
    }
  }
}
