import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sampahku_flutter/model/blog_post.dart';
import 'package:sampahku_flutter/model/user.dart';
import 'package:sampahku_flutter/preferences/user_preferences.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/repository/remote/response/history_prediction_response.dart';
import 'package:sampahku_flutter/repository/remote/response/predict_response.dart';
import 'package:sampahku_flutter/repository/remote/response/register_response.dart';
import 'package:sampahku_flutter/repository/remote/response/reminder_response.dart';
import 'package:sampahku_flutter/repository/remote/response/user_response.dart';

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

  Future<UserResponse> getCurrentUser() async {
    UserData? user = await UserPreference.getUserData();
    String? token = user!.user!.stsTokenManager.accessToken;
    token = token?.trim();

    final url = Uri.parse("${baseUrl}/api/v1/users");

    if (token != null && token.isNotEmpty) {
      final response = await http.get(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("response fetch use: ${response.statusCode} ${response.body}");

      // If the response is successful, decode it into your HistoryPredictionResponse model
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        UserResponse responseBody = UserResponse.fromJson(data);
        return responseBody;
      } else {
        throw Exception('Failed to load prediction history');
      }
      try {} catch (e) {
        print("Error: $e");
        return UserResponse(
          success: false,
          message: "Something went wrong",
        );
      }
    } else {
      return UserResponse(success: false, message: "No valid token");
    }
  }

  Future<String> getBinaryData(File imageFile) async {
    try {
      // Baca file sebagai byte array
      final bytes = await imageFile.readAsBytes();

      // Ubah byte array menjadi string base64
      final base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      print('Error reading file: $e');
      return '';
    }
  }

  Future<PredictResponse> predictImage(File imageFile) async {
    String url = "$baseUrl/api/v1/predicts";

    UserData? user = await UserPreference.getUserData();
    String? token = user!.user!.stsTokenManager.accessToken;
    token = token?.trim();

    try {
      String? mimeType = lookupMimeType(imageFile.path);
      if (mimeType == null ||
          (!mimeType.contains('image/jpeg') &&
              !mimeType.contains('image/png'))) {
      return PredictResponse(success: false, message: "Invalid file type. Only JPEG, PNG, and JPG are allowed.");
      }
      // Prepare multipart request
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri);

      // Menambahkan file dengan key 'predict'
      var multipartFile = await http.MultipartFile.fromPath(
        'predictImage', // Key untuk file
        imageFile.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      // Menambahkan header Authorization dengan token
      request.headers['Authorization'] = 'Bearer $token';

      final response = await http.Response.fromStream(await request.send());
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Parse response ke dalam PredictResponse
      PredictResponse predictResponse = PredictResponse.fromJson(responseData);

      return predictResponse;
    } catch (e) {
      print('Error: $e');
      return PredictResponse(success: false, message: "Error : $e");
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
        print("response set reminder: ${response.statusCode} ${response.body}");

        var data = jsonDecode(response.body);
        ReminderResponse responseBody = ReminderResponse.fromJson(data);

        return responseBody;
      } catch (e) {
        print("Error: $e");
        return ReminderResponse(
          message: "Something went wrong",
          success: false,
        );
      }
    } else {
      return ReminderResponse(
        message: "Something went wrong",
        success: false,
      );
    }
  }

  Future<HistoryPredictionResponse> fetchHistoryPrediction() async {
    UserData? user = await UserPreference.getUserData();
    String? token = user!.user!.stsTokenManager.accessToken;
    token = token?.trim();
    final url = Uri.parse("${baseUrl}/api/v1/predicts");

    if (token != null && token.isNotEmpty) {
      try {
        final response = await http.get(
          url,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        print(
            "response fetch history prediction: ${response.statusCode} ${response.body}");

        // If the response is successful, decode it into your HistoryPredictionResponse model
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          HistoryPredictionResponse responseBody =
              HistoryPredictionResponse.fromJson(data);
          return responseBody;
        } else {
          throw Exception('Failed to load prediction history');
        }
      } catch (e) {
        print("Error: $e");
        return HistoryPredictionResponse(
          success: false,
          message: "Something went wrong",
          currentPage: 0,
          totalData: 0,
          totalPage: 0,
          data: [],
        );
      }
    } else {
      return HistoryPredictionResponse(
        success: false,
        message: "No valid token",
        currentPage: 0,
        totalData: 0,
        totalPage: 0,
        data: [],
      );
    }
  }

  Future<ReminderResponse> getReminder() async {
    UserData? user = await UserPreference.getUserData();
    String? token = user!.user!.stsTokenManager.accessToken;
    token = token?.trim();

    final url = Uri.parse("${baseUrl}/api/v1/reminders");

    if (token != null && token.isNotEmpty) {
      try {
        final response = await http.get(
          url,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );
        print(
            "response fetch reminder: ${response.statusCode} ${response.body}");

        // If the response is successful, decode it into your HistoryPredictionResponse model
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          ReminderResponse responseBody = ReminderResponse.fromJson(data);
          return responseBody;
        } else {
          throw Exception('Failed to load prediction history');
        }
      } catch (e) {
        print("Error: $e");
        return ReminderResponse(
          success: false,
          message: "Something went wrong",
        );
      }
    } else {
      return ReminderResponse(success: false, message: "No valid token");
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
