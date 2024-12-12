import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/preferences/user_preferences.dart';
import 'package:sampahku_flutter/model/user.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/view/dashboard_screen.dart';
import 'package:sampahku_flutter/view/login_screen.dart';
import 'package:sampahku_flutter/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Panggil getUserData() dan tunggu hasilnya, lalu lanjutkan ke layar berikutnya
    _checkUserStatus();

  }

  // Cek status login user dan arahkan ke layar yang sesuai
  Future<void> _checkUserStatus() async {
    // Tunggu hasil getUserData, kemudian lakukan navigasi ke layar yang sesuai
    final UserData? user = await UserPreference.getUserData();

    // Memeriksa apakah data user null atau tidak sebelum melanjutkan ke layar
    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        
          goToHomeScreen();
      } else {
        goToLoginScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: Image.asset("assets/img/logo.png"),
        ),
      ),
    );
  }

  void goToLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
