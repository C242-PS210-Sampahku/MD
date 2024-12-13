
class RegisterResponse {
  bool success;
  String? message;

  RegisterResponse({
    required this.success,
    this.message
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success']??json['status'] ?? true,
      message: json['message'],
    );
  }
}

