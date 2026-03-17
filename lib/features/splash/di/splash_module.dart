import 'package:get_it/get_it.dart';
import '../domain/usecases/check_auth_status_usecase.dart';
// import '../presentation/bloc/splash_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void registerSplashModule(GetIt sl) {
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
}
