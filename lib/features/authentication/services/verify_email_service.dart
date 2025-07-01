import 'dart:convert';
import 'package:http/http.dart' as http;

class VerifyEmailService {
  static const String baseUrl = 'http://192.168.1.71:5001';
  static const String apiPath = '/api/v1/auth';

  Future<bool> verifyEmail(String token) async {
    try {
      // Ensure the URL has the correct path
      final url = '$baseUrl$apiPath/verifyEmail?token=$token';
      print('VerifyEmailService - Making verification request');
      print('VerifyEmailService - Request URL: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      print('VerifyEmailService - Response Status Code: ${response.statusCode}');
      print('VerifyEmailService - Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'] as String?;

        // Consider both success messages as successful verification
        if (message == 'Email verified successfully' || message == 'Email already verified') {
          print('VerifyEmailService - Email verified successfully or already verified');
          return true;
        } else {
          print('VerifyEmailService - Unexpected success message: $message');
          throw Exception('Unexpected response: $message');
        }
      } else {
        print('VerifyEmailService - Verification failed: ${response.body}');
        throw Exception('Failed to verify email: ${response.body}');
      }
    } catch (e) {
      print('VerifyEmailService - Exception occurred: $e');
      throw Exception('Failed to verify email: $e');
    }
  }
} 