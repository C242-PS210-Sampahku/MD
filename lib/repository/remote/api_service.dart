import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampahku_flutter/model/blog_post.dart';
import 'package:sampahku_flutter/model/user.dart';
import 'package:sampahku_flutter/preferences/user_preferences.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/repository/remote/response/register_response.dart';
import 'package:sampahku_flutter/repository/remote/response/reminder_response.dart';

class ApiService {
  final String baseUrl = "https://my-api-402009767733.asia-southeast2.run.app";

  Future<LoginResponse> userLogin(String email, String password) async {
    final url = Uri.parse("${baseUrl}/api/v1/login");

    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
      );
      print("response login: ${response.statusCode} ${response.body}");

      var data = jsonDecode(response.body);
      LoginResponse responseBody = LoginResponse.fromJson(data);

      return responseBody;
    } catch (e) {
      print("Error: $e");
      return LoginResponse(
          message: "Something went wrong", success: false, data: null);
    }
  }

  Future<RegisterResponse> userRegister(String email, String password,
      String username, String name, String gender) async {
    final url = Uri.parse("${baseUrl}/api/v1/register");

    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
          'username': username,
          'name': name,
          'gender': gender
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
      );

      print("response register: ${response.statusCode} ${response.body}");

      var data = jsonDecode(response.body);
      RegisterResponse responseBody = RegisterResponse.fromJson(data);

      return responseBody;
    } catch (e) {
      print("Error: $e");
      return RegisterResponse(
          message: "Network error or invalid response", success: false);
    }
  }

  Future<ReminderResponse> setReminder(String reminders) async {
    UserData? user = await UserPreference.getUserData();
    String? token = user!.user!.stsTokenManager.accessToken;
    token = token?.trim();
    final url = Uri.parse("${baseUrl}/api/v1/reminders");

    if (token != null && token.isNotEmpty) {
      try {
        final response = await http.post(
          url,
          body: reminders,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        print(token);
        print("response set reminder: ${response.statusCode} ${response.body}");

        var data = jsonDecode(response.body);
        ReminderResponse responseBody = ReminderResponse.fromJson(data);

        return responseBody;
      } catch (e) {
        print("Error: $e");
        return ReminderResponse(
            message: "Something went wrong", success: false, count: null);
      }
    }else{
        return ReminderResponse(
            message: "Something went wrong", success: false, count: null);
      }
  }
}
class WordPressApi {
  final String baseUrl = "https://sampahkuid.ddns.net";

  Future<List<BlogPost>> fetchPosts() async {
    final url = Uri.parse('$baseUrl/wp-json/wp/v2/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);

      // Mengembalikan daftar BlogPost yang diambil dari JSON
      return body.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      // Jika status code bukan 200, lemparkan Exception
      throw Exception('Failed to load posts');
    }
  }
}
