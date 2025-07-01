import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movoprive/features/authentication/otp/cubit/otp_state.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthService _authService;
  final String tag = 'OtpCubit';

  OtpCubit(this._authService) : super(OtpInitial());

  Future<void> verifyOtp(String userId, String otp) async {
    try {
      emit(OtpLoading());
      AppLogger.i(tag, 'OTP verification started for user: $userId');
      
      final response = await _authService.verifyOtp(userId, otp);
      AppLogger.i(tag, 'OTP verification successful: ${response.data.message}');
      
      // Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data.token);
      await prefs.setString('userId', userId); // Use the userId we already have
      AppLogger.i(tag, 'Token saved to SharedPreferences');
      
      emit(OtpSuccess(response, response.data.token));
    } catch (e) {
      AppLogger.e(tag, 'OTP verification error', e);
      emit(OtpFailure(e.toString()));
    }
  }
} 