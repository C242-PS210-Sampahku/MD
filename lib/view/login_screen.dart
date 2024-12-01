import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/dashboard_screen.dart';
import 'package:sampahku_flutter/view/main_screen.dart';
import 'package:sampahku_flutter/view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: deviceWidth,
        height: deviceHeight,
        color: AppColor.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight * 0.020,),
              SizedBox(
                height: deviceHeight * 0.2,
                child: Image.asset(
                  "assets/img/logo.png",
                  scale: 1.8,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: deviceHeight * 0.8,
                child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: AppColor.primaryColor),
                          ),
                          Text(
                            "Silahkan Log In untuk masuk ke aplikasi",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    fillColor: AppColor.fillInputBox,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    fillColor: AppColor.fillInputBox,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: InkWell(
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text("LUPA PASSWORD?")],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.03,
                          ),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () =>goToHomeScreen(),
                                child: Text("LOG IN"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.secondaryColor,
                                    foregroundColor: Colors.white,
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          Divider(
                            height: deviceHeight * 0.05,
                          ),
                          Center(
                            child: SizedBox(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/img/google_logo.png",
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Expanded(
                                            child: Text(
                                          "Sign in with Google",
                                          textAlign: TextAlign.center,
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    textStyle: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          Column(
                            
                              children: [
                                Center(
                                  child: InkWell(
                                    child: Text("Tidak memiliki akun? Daftar"),
                                    onTap: () => goToRegisterScreen(),
                                  ),
                                ),
                                Center(
                                  child: Text("v.1.1.0"),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToHomeScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainScreen()));
  }
  
  goToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
  }
}


