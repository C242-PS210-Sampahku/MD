
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';

class UserResponse {
  final bool success;
  final String message;
  final UserDataGet? data;

  UserResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? UserDataGet.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}


class UserDataGet{

  final String? userId;
  final String? name;
  final String? gender;
  final String? username;
  final String? email;
  final String? noHp;
  final String? imgUrl;

  UserDataGet({
     this.userId,
     this.name,
     this.gender,
     this.username,
     this.email,
     this.noHp,
     this.imgUrl,
  });

  factory UserDataGet.fromJson(Map<String, dynamic> json) {
    return UserDataGet(
      userId: json['user_id']  ?? "",
      name: json['name']   ?? "",
      gender: json['gender']   ?? "",
      username: json['username']   ?? "",
      email: json['email']   ?? "",
      noHp: json['no_hp'] ?? "",
      imgUrl: json['img_url']   ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'gender': gender,
      'username': username,
      'email': email,
      'no_hp': noHp,
      'img_url': imgUrl,
    };
  }
}

