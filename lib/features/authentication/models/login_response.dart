class LoginResponse {
  final String message;
  final LoginData data;

  LoginResponse({required this.message, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginData {
  final String message;
  final String userId;

  LoginData({required this.message, required this.userId});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      message: json['message'] ?? '',
      userId: json['userId'] ?? '',
    );
  }
} 