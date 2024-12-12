
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/repository/remote/response/register_response.dart';

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
          message: "Network error or invalid response", success: false, data: null);
    }
  }

  Future<RegisterResponse> userRegister(String email, String password, String username, String name, String gender) async {
    final url = Uri.parse("${baseUrl}/api/v1/register");


    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email, 'password': password, 'username' : username, 'name' : name, 'gender' : gender}),
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
}