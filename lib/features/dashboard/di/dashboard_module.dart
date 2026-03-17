import 'package:get_it/get_it.dart';
import '../data/data_sources/dashboard_remote_data_source.dart';
import '../data/repositories/dashboard_repository_impl.dart';
import '../domain/repositories/dashboard_repository.dart';
import '../domain/usecases/get_dashboard_data_usecase.dart';
import '../presentation/bloc/dashboard_bloc.dart';

void registerDashboardModule(GetIt sl) {

  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(
    () => GetDashboardDataUseCase(sl()),
  );

  sl.registerFactory(
    () => DashboardBloc(sl()),
  );
}