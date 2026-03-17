// domain/repositories/matrimony_repository.dart

import '../entities/matrimony_profile_entity.dart';

abstract class MatrimonyRepository {
  Future<List<MatrimonyProfileEntity>> getProfiles();
}