import 'package:sampahku_flutter/model/reminder.dart';

class ReminderResponse {
  bool success;
  String? message;
  List<ReminderModel>? reminders;

  ReminderResponse({
    required this.success,
    this.message,
    this.reminders,
  });

  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      success: json['success'] ?? json['status'] ?? false,
      message: json['message'] ?? "",
      reminders: json["data"] != null
          ? (json["data"] as List).map((item) => ReminderModel.fromJson(item)).toList()
          : null, // Parsing List ke List<ReminderModel>
    );
  }
}
