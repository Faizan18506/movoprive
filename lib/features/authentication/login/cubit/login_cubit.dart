import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;
  final String tag = 'LoginCubit';

  LoginCubit(this._authService) : super(LoginInitial());

  Future<void> loginWithEmail(String email, String password) async {
    try {
      emit(LoginLoading());
      AppLogger.i(tag, 'Login started for email: $email');

      final response = await _authService.login(email, password);
      AppLogger.i(tag, 'Login successful, user ID: ${response.data.userId}');

      // Save user ID to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response.data.userId);
      AppLogger.i(tag, 'User ID saved to SharedPreferences');

      emit(LoginSuccess(response, response.data.userId));
    } catch (e) {
      AppLogger.e(tag, 'Login error', e);

      // Extract clean message from exception
      String errorMessage = e.toString();

      // Remove any "Exception:" prefix if present
      if (errorMessage.startsWith('Exception:')) {
        errorMessage = errorMessage.substring('Exception:'.length).trim();
      }

      // Check for nested exceptions and extract the core message
      if (errorMessage.contains('Exception:')) {
        final startIndex = errorMessage.lastIndexOf('Exception:') + 'Exception:'.length;
        errorMessage = errorMessage.substring(startIndex).trim();
      }

      // Remove any other exception wrapper text
      if (errorMessage.contains('Failed to login: ')) {
        errorMessage = errorMessage.replaceAll('Failed to login: ', '');
      }

      emit(LoginFailure(errorMessage));
    }
  }
} 