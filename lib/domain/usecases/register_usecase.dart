import '../repositories/auth_repository.dart';
import '../../data/models/user/register_request.dart';
import '../entities/user_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> call(RegisterRequest request) {
    return repository.register(request);
  }
}
