import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/LoginResponse.dart';
import 'package:sampahku_flutter/repository/remote/response/user_response.dart';
import 'package:sampahku_flutter/view/login_screen.dart';
import 'package:sampahku_flutter/viewmodel/login_view_model.dart';
import 'package:sampahku_flutter/viewmodel/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var deviceWidth, deviceHeight;
  ProfileViewModel? viewModel;
  @override
  Widget build(BuildContext context) {

    viewModel = Provider.of<ProfileViewModel>(context);

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(future: fetchUser(), builder: (context, snapshot){
          
          if(snapshot.connectionState == ConnectionState.done){
            return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.thirthyColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                    width: deviceWidth,
                    padding: EdgeInsets.all(20),
                    height: deviceHeight * 0.25,
                    child: Column(
                      children: [
                        Text(
                          "Edit Profil",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          width: deviceWidth * 0.3,
                          height: deviceWidth * 0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: snapshot.data!.imgUrl != null && snapshot.data!.imgUrl!.isNotEmpty? Image.network(snapshot.data!.imgUrl.toString()) : Icon(
                            Icons.person,
                            size: deviceWidth * 0.2,
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: deviceWidth * 0.1,
                            height: deviceWidth * 0.1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(Icons.edit_square),
                          ),
                        )
                      ],
                    ),
                    left: deviceWidth * 0.35,
                    top: deviceWidth * 0.25,
                  ),
                ],
              ),
              form(snapshot.data)
            ],
          ),
        );
          }
          return Container();
        }));
  }

  Widget form(UserDataGet? data) {

    return Container(
        padding: EdgeInsets.all(35),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama Lengkap",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      fillColor: AppColor.fillInputBox,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: data?.name ?? "Nama Lengkap",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      fillColor: AppColor.fillInputBox,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.grey,
                      ),
                      hintText: data?.username ?? "Username",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      fillColor: AppColor.fillInputBox,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      hintText:data?.email ?? "Email",
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jenis Kelamin",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      fillColor: AppColor.fillInputBox,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(
                        Icons.male,
                        color: Colors.grey,
                      ),
                      hintText: data?.gender ?? "L/P",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No Handphone",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      fillColor: AppColor.fillInputBox,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.grey,
                      ),
                      hintText: data!.noHp != null && data!.noHp!.isNotEmpty?  data!.noHp :  "No Handphone",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(onPressed: () {
                viewModel!.logout(context).then((v){
                  _goToLogin();
                });
              }, child: Text("Logout")),
            )
          ],
        )));
  }
  
  void _goToLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
}

Future<UserDataGet?> fetchUser() async {
  ApiService apiService = ApiService();
  UserResponse response =  await apiService.getCurrentUser();

  if(response.success){
    if(response.data != null){
      return response.data;
    }else{

    return null;
    }
  }else{
    
    return null;
  }
}
