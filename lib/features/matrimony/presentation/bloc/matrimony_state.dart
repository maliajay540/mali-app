import '../../domain/entities/matrimony_profile_entity.dart';

abstract class MatrimonyState {}

class MatrimonyInitial extends MatrimonyState {}

class MatrimonyLoading extends MatrimonyState {}

class MatrimonyLoaded extends MatrimonyState {
  final List<MatrimonyProfileEntity> profiles;

  MatrimonyLoaded(this.profiles);
}

class MatrimonyError extends MatrimonyState {
  final String message;

  MatrimonyError(this.message);
}