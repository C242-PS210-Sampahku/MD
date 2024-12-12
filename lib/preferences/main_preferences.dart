import 'dart:convert';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

import '../repository/remote/response/LoginResponse.dart';

class MainPreferences {
  static const String _preferencesKey = 'preferences';

  // Save Setup schedule to SharedPreferences
  static Future<void> setSetupSchedule(bool finish) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_preferencesKey, finish);
    print("Setup schedule saved.");
  }

  // Retrieve Setup schedule from SharedPreferences
  static Future<bool> getSetupSchdele() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isFinishedSetupSchedule = prefs.getBool(_preferencesKey);

    if (isFinishedSetupSchedule == null) {
      print("Setup schedule not found.");
      return false;
    }

    return isFinishedSetupSchedule;
  }

  // Delete Setup schedule from SharedPreferences
  static Future<void> clearSetupSchedule() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_preferencesKey);
    print("Setup schedule cleared.");
  }
}
