import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movoprive/features/authentication/models/login_response.dart';
import 'package:movoprive/features/authentication/models/otp_response.dart';
import 'package:movoprive/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.1.71:5001/api/v1/auth';
  final String tag = 'AuthService';

  Future<LoginResponse> login(String email, String password) async {
    try {
      AppLogger.i(tag, 'Attempting login with email: $email');

      final requestBody = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      AppLogger.api(
          '$baseUrl/login',
          'POST',
          requestBody,
          response.body,
          response.statusCode
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.i(tag, 'Login successful, parsing response');
        return LoginResponse.fromJson(responseData);
      } else {
        AppLogger.e(tag, 'Login failed with status code: ${response.statusCode}');
        // Check if response contains a "user already logged in" message
        if (responseData['message'] != null &&
            responseData['message'].toString().toLowerCase().contains('user already logged in')) {
          // Throw the direct message without wrapping in Exception
          throw 'User already logged in';
        } else {
          throw responseData['message'] ?? 'Failed to login';
        }
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during login', e);
      // If it's already a string (like our custom message), don't wrap it again
      if (e is String) {
        throw e;
      } else {
        throw 'Failed to login';
      }
    }
  }

  Future<OtpResponse> verifyOtp(String userId, String otp) async {
    try {
      AppLogger.i(tag, 'Attempting to verify OTP for user: $userId');
      
      final requestBody = {
        'userId': userId,
        'otp': otp,
      };
      
      final response = await http.post(
        Uri.parse('$baseUrl/verifyOtp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      AppLogger.api(
        '$baseUrl/verifyOtp',
        'POST', 
        requestBody, 
        response.body, 
        response.statusCode
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        AppLogger.i(tag, 'OTP verification successful, parsing response');
        return OtpResponse.fromJson(responseData);
      } else {
        AppLogger.e(tag, 'OTP verification failed with status code: ${response.statusCode}');
        throw Exception('Failed to verify OTP. Status code: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during OTP verification', e);
      throw Exception('Failed to verify OTP: $e');
    }
  }

  Future<void> logout(String token) async {
    try {
      AppLogger.i(tag, 'Attempting to logout');
      
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      AppLogger.api(
        '$baseUrl/logout',
        'POST',
        {},
        response.body,
        response.statusCode
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.i(tag, 'Logout successful');
      } else {
        AppLogger.e(tag, 'Logout failed with status code: ${response.statusCode}');
        throw Exception('Failed to logout');
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during logout', e);
      throw Exception('Failed to logout: $e');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      AppLogger.i(tag, 'Attempting to send forgot password request for email: $email');
      
      final response = await http.post(
        Uri.parse('$baseUrl/forgetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      AppLogger.api(
        '$baseUrl/forgetPassword',
        'POST',
        {'email': email},
        response.body,
        response.statusCode
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.i(tag, 'Forgot password request successful');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        AppLogger.i(tag, 'Response data: $responseData');
        return responseData;
      } else {
        AppLogger.e(tag, 'Forgot password request failed with status code: ${response.statusCode}');
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        throw errorData['message'] ?? 'Failed to process forgot password request';
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during forgot password request', e);
      throw e.toString();
    }
  }

  Future<void> resetPassword(String newPassword, String confirmPassword, String token) async {
    try {
      AppLogger.i(tag, 'Attempting to reset password');
      
      final response = await http.post(
        Uri.parse('$baseUrl/resetPassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      AppLogger.api(
        '$baseUrl/resetPassword',
        'POST',
        {
          'token': token,
          'newPassword': '***',
          'confirmPassword': '***',
        },
        response.body,
        response.statusCode
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.i(tag, 'Password reset successful');
      } else {
        AppLogger.e(tag, 'Password reset failed with status code: ${response.statusCode}');
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        throw errorData['message'] ?? 'Failed to reset password';
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during password reset', e);
      throw e.toString();
    }
  }

  Future<void> verifyResetOtp(String otp, String userId) async {
    try {
      AppLogger.i(tag, 'Attempting to verify reset OTP');
      
      final response = await http.post(
        Uri.parse('$baseUrl/verifyResetOtp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'otp': otp,
          'userId': userId,
        }),
      );

      AppLogger.api(
        '$baseUrl/verifyResetOtp',
        'POST',
        {
          'otp': '***',
          'userId': userId,
        },
        response.body,
        response.statusCode
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLogger.i(tag, 'Reset OTP verification successful');
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Store the token for password reset
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('resetToken', responseData['data']['token']);
      } else {
        AppLogger.e(tag, 'Reset OTP verification failed with status code: ${response.statusCode}');
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        throw errorData['message'] ?? 'Failed to verify OTP';
      }
    } catch (e) {
      AppLogger.e(tag, 'Exception during reset OTP verification', e);
      throw e.toString();
    }
  }
} 