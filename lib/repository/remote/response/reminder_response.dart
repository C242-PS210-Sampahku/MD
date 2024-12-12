
class ReminderResponse {
  bool success;
  String? message;
  int? count;

  ReminderResponse({
    required this.success,
    this.message,
    this.count,

  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      success: json['success']??json['status'] ?? false,
      message: json['message']?? "",
      count: json["data"] != null ? json["data"]["count"]: null,
    );
  }

  
}
