import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtpUseCase sendOtp;
  final VerifyOtpUseCase verifyOtp;

  AuthBloc({required this.sendOtp, required this.verifyOtp})
    : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<VerifyOtpEvent>(_verifyOtp);
  }

  Future<void> _sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await sendOtp(event.phone);

      emit(OtpSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await verifyOtp(phone: event.phone, otp: event.otp);

      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
