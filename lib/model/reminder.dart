
class ReminderModel {
  final int reminderId;
  final String userId;
  final String day;
  final String time;
  final String createdAt;
  final String updatedAt;
  final bool isActived;
  int? count;

  ReminderModel({
    required this.reminderId,
    required this.userId,
    required this.day,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.isActived,
    this.count
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      reminderId: json['reminder_id'] ?? 0,
      userId: json['user_id'] ?? "",
      day: json['day'] ?? "",
      time: json['time'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      isActived: json['is_actived'] ?? false,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reminder_id': reminderId,
      'user_id': userId,
      'day': day,
      'time': time,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_actived': isActived,
      'count': count ?? 0,
    };
  }
}