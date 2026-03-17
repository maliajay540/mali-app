// data/repositories/matrimony_repository_impl.dart

import '../../domain/entities/matrimony_profile_entity.dart';
import '../../domain/repositories/matrimony_repository.dart';
import '../data_sources/matrimony_remote_data_source.dart';

class MatrimonyRepositoryImpl implements MatrimonyRepository {
  final MatrimonyRemoteDataSource remoteDataSource;

  MatrimonyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MatrimonyProfileEntity>> getProfiles() {
    return remoteDataSource.getProfiles();
  }
}