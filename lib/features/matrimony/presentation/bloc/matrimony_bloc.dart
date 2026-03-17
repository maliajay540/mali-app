import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_profiles_usecase.dart';
import 'matrimony_event.dart';
import 'matrimony_state.dart';

class MatrimonyBloc extends Bloc<MatrimonyEvent, MatrimonyState> {
  final GetProfilesUseCase getProfiles;

  MatrimonyBloc(this.getProfiles) : super(MatrimonyInitial()) {
    on<LoadProfiles>((event, emit) async {
      emit(MatrimonyLoading());

      try {
        final data = await getProfiles();
        emit(MatrimonyLoaded(data));
      } catch (e) {
        emit(MatrimonyError(e.toString()));
      }
    });
  }
}