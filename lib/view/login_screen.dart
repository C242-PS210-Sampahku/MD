import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:provider/provider.dart';
import 'package:sampahku_flutter/view/dashboard_screen.dart';
import 'package:sampahku_flutter/view/main_screen.dart';
import 'package:sampahku_flutter/view/register_screen.dart';
import 'package:sampahku_flutter/viewmodel/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    var loginViewModel = Provider.of<LoginViewModel>(context);

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          width: deviceWidth,
          height: deviceHeight,
          color: AppColor.primaryColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.020,
                    ),
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
                          child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Email tidak boleh kosong!';
                                            }
                                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                                .hasMatch(value)) {
                                              return 'Masukkan email yang valid!';
                                            }
                                            return null;
                                          },
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              fillColor: AppColor.fillInputBox,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15),
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.grey,
                                              ),
                                              hintText: "Email Address",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password tidak boleh kosong!';
                                            }
                                            if (value.toString().length < 8) {
                                              return 'Password harus lebih dari 8 karakter!';
                                            }
                                            return null;
                                          },
                                          obscureText: hidePassword,
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                              fillColor: AppColor.fillInputBox,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 15),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.grey,
                                              ),
                                              suffixIcon: InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    hidePassword = !hidePassword;
                                                  });
                                                },
                                                child: hidePassword? Icon(
                                                  Icons.visibility_off,
                                                  color: Colors.grey,
                                                ) : Icon(
                                                  Icons.visibility,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              hintText: "Password",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey)),
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
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              loginViewModel.setEmail(
                                                  emailController.text);
                                              loginViewModel.setPassword(
                                                  passwordController.text);
                                              loginViewModel
                                                  .login()
                                                  .then((value) {
                                                if (loginViewModel.errorMsg !=
                                                    null) {
                                                  Fluttertoast.showToast(
                                                      msg: loginViewModel
                                                          .errorMsg!);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Login Berhasil!");
                                                  goToHomeScreen();
                                                }
                                              });
                                            }
                                          },
                                          child: Text("LOG IN"),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.secondaryColor,
                                              foregroundColor: Colors.white,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: deviceHeight * 0.05,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            loginViewModel.loginGoogle();
                                          },
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/img/google_logo.png",
                                                  width: 20,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  "Sign in with Google",
                                                  textAlign: TextAlign.center,
                                                ))
                                              ],
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 10,
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
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
                                            child: Text(
                                                "Tidak memiliki akun? Daftar"),
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
                              ))),
                    )
                  ],
                ),
              ),
              loading(loginViewModel),
            ],
          )),
    );
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  goToRegisterScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  loading(LoginViewModel loginViewModel) {
    if (loginViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SizedBox.shrink();
    }
  }
}
