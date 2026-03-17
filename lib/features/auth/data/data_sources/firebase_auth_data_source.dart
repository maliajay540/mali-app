import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDataSource {
  FirebaseAuth get firebaseAuth;

  Future<void> sendOtp(String phone);

  Future<String> verifyOtp({required String otp});
}
