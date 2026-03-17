import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/data_sources/firebase_auth_data_source.dart';
import '../data/data_sources/firebase_auth_data_source_impl.dart';
import '../data/data_sources/auth_api_data_source.dart';
import '../data/data_sources/auth_api_data_source_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/send_otp_usecase.dart';
import '../domain/usecases/verify_otp_usecase.dart';
import '../presentation/bloc/auth_bloc.dart';

void registerAuthModule(GetIt sl) {
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthApiDataSource>(
    () => AuthApiDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => SendOtpUseCase(sl()));

  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));

  sl.registerFactory(() => AuthBloc(sendOtp: sl(), verifyOtp: sl()));
}
