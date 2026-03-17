import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'auth_api_data_source.dart';

class AuthApiDataSourceImpl implements AuthApiDataSource {

  final Dio dio;
  final storage = const FlutterSecureStorage();

  AuthApiDataSourceImpl(this.dio);

  @override
  Future<UserModel> loginWithPhone({
    required String phone,
    required String firebaseUid,
  }) async {

    final response = await dio.post(
      "/login",
      data: {
        "phone": phone,
        "firebase_uid": firebaseUid,
      },
    );

    print("LOGIN RESPONSE: ${response.data}");

    // token save
    await storage.write(
      key: "token",
      value: response.data["token"],
    );

    return UserModel.fromJson(response.data["user"]);
  }
}