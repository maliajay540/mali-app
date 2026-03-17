import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> sendOtp(String phone);

  Future<UserEntity> verifyOtp({required String phone, required String otp});

  Future<bool> isLoggedIn();
}
