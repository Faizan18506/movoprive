import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/verify_email_service.dart';
import 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final VerifyEmailService _verifyEmailService;

  VerifyEmailCubit(this._verifyEmailService) : super(VerifyEmailInitial());

  Future<void> verifyEmail(String token) async {
    try {
      emit(VerifyEmailLoading());
      final success = await _verifyEmailService.verifyEmail(token);
      if (success) {
        emit(VerifyEmailSuccess());
      } else {
        emit(VerifyEmailError('Failed to verify email'));
      }
    } catch (e) {
      emit(VerifyEmailError(e.toString()));
    }
  }
} 