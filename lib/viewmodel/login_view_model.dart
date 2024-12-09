import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sampahku_flutter/data/user_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  String? _errorMsg;
  String? get errorMsg => _errorMsg;

  String _email = '';
  String _password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> loginGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if(user != null){
        await saveUserData(user);
        print(user);
      }
      else{
        return;
      }

    }  catch (e) {
      print("Error : ${e}");
      return ;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login() async {
    _isLoading = true;
    _errorMsg = null;
    notifyListeners();

    try {
      var userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);

      User? user = userCredentials.user;

      if(user != null){
        saveUserData(user);
      }

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        _errorMsg = "Akun tidak ditemukan.";
      } else if (e.code == "wrong-password") {
        _errorMsg = "Email atau password salah!";
      } else if (e.code == "too-many-requests") {
        _errorMsg = "Terlalu banyak percobaan login. coba lagi nanti.";
      } else {
        _errorMsg = "Terjadi kesalahan: ${e.message}.";
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
