import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(
      Duration(seconds: 2), (){
        goToLoginScreen();
      }
    );

    return  Scaffold(
      body: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: Image(image: AssetImage("assets/img/logo.png")),
        ),
      ),
    );
  }
  
  void goToLoginScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}