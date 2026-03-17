// di/matrimony_module.dart

import 'package:get_it/get_it.dart';
import '../data/data_sources/matrimony_remote_data_source.dart';
import '../data/repositories/matrimony_repository_impl.dart';
import '../domain/repositories/matrimony_repository.dart';
import '../domain/usecases/get_profiles_usecase.dart';
import '../presentation/bloc/matrimony_bloc.dart';

final sl = GetIt.instance;

void initMatrimonyModule() {
  sl.registerLazySingleton<MatrimonyRemoteDataSource>(
    () => MatrimonyRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<MatrimonyRepository>(
    () => MatrimonyRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProfilesUseCase(sl()));

  sl.registerFactory(() => MatrimonyBloc(sl()));
}