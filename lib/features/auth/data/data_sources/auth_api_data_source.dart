import '../models/user_model.dart';

abstract class AuthApiDataSource {

  Future<UserModel> loginWithPhone({
    required String phone,
    required String firebaseUid,
  });

}