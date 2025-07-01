class RegisterResponse {
  final String message;
  final RegisterData data;

  RegisterResponse({required this.message, required this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] ?? '',
      data: RegisterData.fromJson(json['data'] ?? {}),
    );
  }
}

class RegisterData {
  final String message;

  RegisterData({required this.message});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      message: json['message'] ?? '',
    );
  }
} 