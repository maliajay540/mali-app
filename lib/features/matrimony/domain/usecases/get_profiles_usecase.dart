// domain/usecases/get_profiles_usecase.dart

import '../entities/matrimony_profile_entity.dart';
import '../repositories/matrimony_repository.dart';

class GetProfilesUseCase {
  final MatrimonyRepository repository;

  GetProfilesUseCase(this.repository);

  Future<List<MatrimonyProfileEntity>> call() {
    return repository.getProfiles();
  }
}