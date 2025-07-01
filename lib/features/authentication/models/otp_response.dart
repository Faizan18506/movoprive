class OtpResponse {
  final String message;
  final OtpData data;

  OtpResponse({required this.message, required this.data});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      message: json['message'] ?? '',
      data: OtpData.fromJson(json['data'] ?? {}),
    );
  }
}

class OtpData {
  final String message;
  final String token;

  OtpData({required this.message, required this.token});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }
} 