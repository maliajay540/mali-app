import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc
    extends Bloc<DashboardEvent, DashboardState> {

  final GetDashboardDataUseCase useCase;

  DashboardBloc(this.useCase)
      : super(DashboardInitial()) {

    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final data = await useCase();
        emit(DashboardLoaded(data));
      } catch (e) {
        emit(DashboardError("Failed to load dashboard"));
      }
    });
  }
}