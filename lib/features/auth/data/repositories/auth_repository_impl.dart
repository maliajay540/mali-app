import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/firebase_auth_data_source.dart';
import '../data_sources/auth_api_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseDataSource;
  final AuthApiDataSource apiDataSource;

  AuthRepositoryImpl(this.firebaseDataSource, this.apiDataSource);

  @override
  Future<void> sendOtp(String phone) {
    return firebaseDataSource.sendOtp(phone);
  }

  @override
  Future<UserEntity> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final uid = await firebaseDataSource.verifyOtp(otp: otp);

    final user = await apiDataSource.loginWithPhone(
      phone: phone,
      firebaseUid: uid,
    );

    return user;
  }

  @override
  Future<bool> isLoggedIn() async {
    return firebaseDataSource.firebaseAuth.currentUser != null;
  }
}
