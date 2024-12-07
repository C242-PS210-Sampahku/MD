import 'package:flutter/material.dart';
import 'package:sampahku_flutter/color/app_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var deviceWidth, deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                          child: Icon(
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
              form()
            ],
          ),
        ));
  }

  Widget form() {
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
                      hintText: "Nama Lengkap",
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
                      hintText: "Username",
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
                  "Tanggal Lahir",
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
                        Icons.calendar_month,
                        color: Colors.grey,
                      ),
                      hintText: "dd/mm/yyyy",
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
                      hintText: "Email",
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
                      hintText: "L/P",
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
                        Icons.mail,
                        color: Colors.grey,
                      ),
                      hintText: "No Handphone",
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
                  "Alamat",
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
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      suffixIcon: InkWell(
                        child: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "Alamat",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ],
        )));
  }
}
