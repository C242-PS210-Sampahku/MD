import 'package:flutter/material.dart';
import 'package:sampahku_flutter/repository/remote/api_service.dart';
import 'package:sampahku_flutter/repository/remote/response/register_response.dart';

class RegisterViewModel extends ChangeNotifier {
  // Error message
  String? _errorMsg;
  String? get errorMsg => _errorMsg;

  // User properties
  String _username = '';
  String get username => _username;
  void setUsername(String username) {
    _username = username.toLowerCase().trim();
    notifyListeners();
  }

  String _name = '';
  String get name => _name;
  void setName(String name) {
    _name = name.trim();
    notifyListeners();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber.trim();
    notifyListeners();
  }

  String _dateOfBirth = '';
  String get dateOfBirth => _dateOfBirth;
  void setDateOfBirth(String dateOfBirth) {
    _dateOfBirth = dateOfBirth.trim();
    notifyListeners();
  }

  String _address = '';
  String get address => _address;
  void setAddress(String address) {
    _address = address.trim();
    notifyListeners();
  }

  String _gender = '';
  String get gender => _gender;
  void setGender(String gender) {
    _gender = gender.trim();
    notifyListeners();
  }

  String _email = '';
  String get email => _email;
  void setEmail(String email) {
    _email = email.trim();
    notifyListeners();
  }

  String _password = '';
  String get password => _password;
  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final ApiService apiService = ApiService();

  // Register function
  Future<void> register() async {
    _isLoading = true;
    notifyListeners();

    // Validasi input wajib
    if (_name.isEmpty) {
      _setError("Nama tidak boleh kosong!");
      return;
    }
    if (_phoneNumber.isEmpty) {
      _setError("Nomor telepon tidak boleh kosong!");
      return;
    }
    if (_dateOfBirth.isEmpty) {
      _setError("Tanggal lahir tidak boleh kosong!");
      return;
    }
    if (_address.isEmpty) {
      _setError("Alamat tidak boleh kosong!");
      return;
    }
    if (_gender.isEmpty) {
      _setError("Jenis kelamin tidak boleh kosong!");
      return;
    }
    if (_email.isEmpty) {
      _setError("Email tidak boleh kosong!");
      return;
    }
    if (_password.isEmpty) {
      _setError("Password tidak boleh kosong!");
      return;
    }
    if (_confirmPassword.isEmpty) {
      _setError("Konfirmasi password tidak boleh kosong!");
      return;
    }
    if (_password != _confirmPassword) {
      _setError("Password tidak sama!");
      return;
    }

    // Validasi tambahan
    if (!_validateAndRegister()) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Proses registrasi
    RegisterResponse response = await apiService.userRegister(
      _email,
      _password,
      _username,
      _name,
      _gender,
    );

    _isLoading = false;
    notifyListeners();

    if (!response.success) {
      _errorMsg = response.message!.contains("prisma")
          ? "Username sudah digunakan!"
          : response.message;
    } else {
      _errorMsg = null; // Berhasil
    }
    notifyListeners();
  }

  bool _validateAndRegister() {
    print("Validate data");

    // Validasi username
    final usernameRegex = RegExp(r'^[a-z0-9]+$');
    if (!usernameRegex.hasMatch(username)) {
      _setError("Username harus huruf kecil tanpa spasi.");
      return false; // Validasi gagal
    }

    // Validasi email
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      _setError("Masukkan email yang valid.");
      return false; // Validasi gagal
    }

    // Validasi password
    final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    if (!passwordRegex.hasMatch(password)) {
      _setError(
          "Password harus memiliki minimal 8 karakter, huruf besar, huruf kecil, dan angka.");
      return false; // Validasi gagal
    }

    // Validasi konfirmasi password
    if (password != confirmPassword) {
      _setError("Password dan konfirmasi password tidak cocok.");
      return false; // Validasi gagal
    }

    _errorMsg = null; // Semua validasi lolos
    notifyListeners();
    return true; // Validasi berhasil
  }

  void _setError(String message) {
    _errorMsg = message;
    _isLoading = false;
    notifyListeners();
  }
}
