import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/auth/di/auth_module.dart';
import '../../features/dashboard/di/dashboard_module.dart';
import '../../features/splash/domain/usecases/check_auth_status_usecase.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {

  /// Dio
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: "https://mali-backend-mg8k.onrender.com/api",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  /// AUTH
  registerAuthModule(sl);

  /// SPLASH
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));
  sl.registerFactory(() => SplashBloc(sl()));

  /// DASHBOARD
  registerDashboardModule(sl);
}