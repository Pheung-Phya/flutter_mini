import '../models/user_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<UserModel> login(LoginRequest request) async {
    final response = await apiClient.client.post(
      '/login',
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data['user']);
  }

  Future<UserModel> register(RegisterRequest request) async {
    final response = await apiClient.client.post(
      '/register',
      data: request.toJson(),
    );
    return UserModel.fromJson(response.data['user']);
  }

  Future<void> logout() async {
    await apiClient.client.post('/logout');
  }
}
