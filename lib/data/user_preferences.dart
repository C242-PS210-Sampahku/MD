import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampahku_flutter/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(User user) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('uid', user.uid);
  await prefs.setString('email', user.email ?? '');
  await prefs.setString('displayName', user.displayName ?? '');
  print("save UID : ${user.uid}");
}

Future<UserModel?> getUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? uid = prefs.getString('uid');
  final String? email = prefs.getString('email');
  final String? displayName = prefs.getString('displayName');

  print("status UID : ${uid}");

  if(prefs.getString("uid") != null){
    return UserModel(uid: uid!, email: email!, displayName: displayName!);
  }else{
    return null;
  }
}
