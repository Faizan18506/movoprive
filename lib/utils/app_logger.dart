import 'dart:developer' as developer;

class AppLogger {
  static void d(String tag, String message) {
    developer.log('[$tag] $message');
  }

  static void i(String tag, String message) {
    developer.log('📘 [$tag] $message');
  }

  static void w(String tag, String message) {
    developer.log('⚠️ [$tag] $message');
  }

  static void e(String tag, String message, [dynamic error]) {
    developer.log('❌ [$tag] $message. ${error != null ? 'Error: $error' : ''}');
  }

  static void api(String endpoint, String method, dynamic request, dynamic response, [int? statusCode]) {
    developer.log('🌐 API Call: $method $endpoint');
    developer.log('📤 Request: $request');
    developer.log('📥 Response (${statusCode ?? 'unknown'}): $response');
  }
} 