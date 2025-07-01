import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register_response.dart';

class RegisterService {
  static const String baseUrl = 'http://192.168.1.71:5001/api/v1';

  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String confirmPassword,
  }) async {
    try {
      final requestBody = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phone,
        'confirmPassword': confirmPassword,
      };

      print('RegisterService - Making registration request');
      print('RegisterService - Request URL: $baseUrl/auth/register');
      print('RegisterService - Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('RegisterService - Response Status Code: ${response.statusCode}');
      print('RegisterService - Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
        print('RegisterService - Successfully parsed response: ${registerResponse.message}');
        return registerResponse;
      } else {
        print('RegisterService - Error Response: ${response.body}');
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      print('RegisterService - Exception occurred: $e');
      throw Exception('Failed to register: $e');
    }
  }
} 