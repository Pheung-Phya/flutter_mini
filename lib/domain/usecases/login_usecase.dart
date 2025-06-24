import '../repositories/auth_repository.dart';
import '../../../data/models/login_request.dart';
import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(LoginRequest request) {
    return repository.login(request);
  }
}
