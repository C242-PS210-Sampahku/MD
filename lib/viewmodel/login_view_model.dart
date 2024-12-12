import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sampahku_flutter/data/user_preferences.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';

class LoginViewModel extends ChangeNotifier {
  String? _errorMsg;
  String? get errorMsg => _errorMsg;

  String _email = '';
  String _password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ApiService apiService = ApiService();

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Future<void> loginGoogle() async {
  //   _isLoading = true;
  //   notifyListeners();


  Future<void> login() async {
    _isLoading = true;
    notifyListeners();


    LoginResponse response = await apiService.userLogin(_email, _password);
    print("Reponse login : ${response.message}");

    _isLoading = false;
    notifyListeners();
    if(!response.success){
      _errorMsg = response.message;
      notifyListeners();
      return;
    }else{
      await UserPreference.saveUserData(response.data!);

      _errorMsg = null;
      return;
    }

  
  }
}
