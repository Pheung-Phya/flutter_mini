import 'package:flutter_mini/domain/repositories/auth_repository.dart';

class OtpVerifyUseCase {
  final AuthRepository repository;

  OtpVerifyUseCase(this.repository);

  Future<void> call(String email, String otpCode) async {
    return repository.verifyOtp(email, otpCode);
  }
}
