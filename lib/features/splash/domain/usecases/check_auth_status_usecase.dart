// import '../../../auth/domain/repositories/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CheckAuthStatusUseCase {
  final FlutterSecureStorage storage;

  CheckAuthStatusUseCase(this.storage);

  Future<bool> call() async {
    final token = await storage.read(key: "token");
    return token != null && token.isNotEmpty;
  }
}