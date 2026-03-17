import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_data_source.dart';

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  @override
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSourceImpl(this.firebaseAuth);

  String? _verificationId;

  @override
  Future<void> sendOtp(String phone) async {
    final completer = Completer<void>();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91$phone",

      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        if (!completer.isCompleted) completer.complete();
      },

      verificationCompleted: (_) {
        if (!completer.isCompleted) completer.complete();
      },

      verificationFailed: (e) {
        if (!completer.isCompleted) {
          completer.completeError(Exception(e.message));
        }
      },

      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId ??= verificationId;
        if (!completer.isCompleted) completer.complete();
      },
    );

    // Wait until codeSent (or error) fires
    await completer.future;
  }

  @override
  Future<String> verifyOtp({required String otp}) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    return userCredential.user!.uid;
  }
}
