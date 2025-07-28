import 'package:flutter_mini/domain/repositories/auth_repository.dart';

class OtpVerifyUseCase {
  final AuthRepository repository;

  OtpVerifyUseCase(this.repository);

  Future<void> call({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
    required String otpCode,
  }) async {
    return repository.verifyOtp(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: passwordConfirmation,
      otpCode: otpCode,
    );
  }
}
