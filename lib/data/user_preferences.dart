import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../repository/remote/response/LoginResponse.dart';

class UserPreference {
  static const String _userDataKey = 'userData';

  // Save UserData to SharedPreferences
  static Future<void> saveUserData(UserData userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userDataJson = jsonEncode(userData.toJson());
    await prefs.setString(_userDataKey, userDataJson);
    print("Save user data successful.");
  }

  // Retrieve UserData from SharedPreferences
  static Future<UserData?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataJson = prefs.getString(_userDataKey);

    if (userDataJson == null) {
      print("No user data found.");
      return null;
    }

    final Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
    return UserData.fromJson(userDataMap);
  }

  // Delete UserData from SharedPreferences
  static Future<void> deleteUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
    print("Delete user data successful.");
  }
}
