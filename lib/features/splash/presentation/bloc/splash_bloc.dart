import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_status_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckAuthStatusUseCase checkAuthStatus;

  SplashBloc(this.checkAuthStatus) : super(SplashInitial()) {
    on<AppStarted>((event, emit) async {
      emit(SplashLoading());

      await Future.delayed(const Duration(seconds: 2));

      final isLoggedIn = await checkAuthStatus();

      if (isLoggedIn) {
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    });
  }
}