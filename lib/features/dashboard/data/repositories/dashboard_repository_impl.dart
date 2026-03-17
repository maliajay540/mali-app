import '../../domain/entities/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_remote_data_source.dart';
import '../models/dashboard_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {

  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<DashboardEntity> getDashboardData() async {
    final json = await remoteDataSource.fetchDashboardData();
    return DashboardModel.fromJson(json);
  }
}