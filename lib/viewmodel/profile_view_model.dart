
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampahku_flutter/preferences/main_preferences.dart';

import 'package:sampahku_flutter/preferences/user_preferences.dart';
import 'package:sampahku_flutter/view/login_screen.dart';

class ProfileViewModel extends ChangeNotifier {
  String? _errorMsg;
  String? get errorMsg => _errorMsg;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> logout(BuildContext context) async {
    UserPreference.deleteUserData().then((ValueNotifier){
      MainPreferences.clearSetupSchedule().then((v){
        Fluttertoast.showToast(msg: "Logout Berhasil!");
      });
    });
  }
}
