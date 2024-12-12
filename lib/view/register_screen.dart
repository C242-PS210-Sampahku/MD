import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sampahku_flutter/color/app_color.dart';
import 'package:sampahku_flutter/view/setup_screen.dart';
import 'package:sampahku_flutter/viewmodel/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingControllers untuk setiap input field
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<RegisterViewModel>(context);

    isLoading = context.watch<RegisterViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const Text("Lengkapi formulir berikut dengan benar."),
                    const SizedBox(height: 10),
                    _buildTextInput("Username", _usernameController,
                        Icons.person, "Username"),
                    const SizedBox(height: 10),
                    _buildTextInput("Nama Lengkap", _fullNameController,
                        Icons.person, "Nama Lengkap"),
                    const SizedBox(height: 10),
                    _buildTextInput("Nomor Handphone", _phoneNumberController,
                        Icons.call, "Nomor Handphone"),
                    const SizedBox(height: 10),
                    _buildDateOfBirthPicker(),
                    const SizedBox(height: 10),
                    _buildTextInput("Alamat Lengkap", _addressController,
                        Icons.location_on, "Alamat Lengkap"),
                    const SizedBox(height: 10),
                    _buildGenderDropdown(),
                    const SizedBox(height: 10),
                    _buildTextInput(
                        "Email", _emailController, Icons.mail, "Email"),
                    const SizedBox(height: 10),
                    _buildTextInput(
                        "Password", _passwordController, Icons.lock, "Password",
                        isPassword: true),
                    const SizedBox(height: 10),
                    _buildTextInput(
                        "Confirm Password",
                        _confirmPasswordController,
                        Icons.lock,
                        "Confirm Password",
                        isPassword: true),
                    const SizedBox(height: 50),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: !isLoading
                              ? () {
                                  // Memasukkan data ke dalam ViewModel
                                  viewModel
                                      .setUsername(_usernameController.text);
                                  viewModel.setName(_fullNameController.text);
                                  viewModel.setPhoneNumber(
                                      _phoneNumberController.text);
                                  viewModel.setDateOfBirth(
                                      _birthDateController.text);
                                  viewModel.setAddress(_addressController.text);
                                  viewModel.setGender(_genderController.text);
                                  viewModel.setEmail(_emailController.text);
                                  viewModel
                                      .setPassword(_passwordController.text);
                                  viewModel.setConfirmPassword(
                                      _confirmPasswordController.text);

                                  viewModel.register().then((value) {
                                    print(
                                        "Error Message : ${viewModel.errorMsg}");
                                    if (viewModel.errorMsg != null) {
                                      Fluttertoast.showToast(
                                          msg: viewModel.errorMsg!);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Berhasil buat akun!");
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondaryColor,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                          child: const Text("Register"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: InkWell(
                        child: const Text("Sudah memiliki akun? Login"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              loading()
            ],
          )),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller,
      IconData icon, String hint,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            fillColor: AppColor.fillInputBox,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  loading() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Jenis Kelamin",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _genderController.text.isEmpty ? null : _genderController.text,
          items: const [
            DropdownMenuItem(
              value: "male",
              child: Text("Laki-Laki"),
            ),
            DropdownMenuItem(
              value: "female",
              child: Text("Perempuan"),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _genderController.text = value ?? ''; // update gender value
            });
          },
          decoration: InputDecoration(
            fillColor: AppColor.fillInputBox,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthPicker() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Tanggal Lahir",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 10),
      TextFormField(
        controller: _birthDateController,
        readOnly: true,  // Disable manual input
        decoration: InputDecoration(
          fillColor: AppColor.fillInputBox,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.grey,
          ),
          hintText: "dd/mm/yyyy",
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        onTap: () async {
          // Show the Date Picker
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AppColor.primaryColor,
                  colorScheme: ColorScheme.light(primary: AppColor.primaryColor),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );

          if (selectedDate != null) {
            // Format the date as dd/MM/yyyy
            String formattedDate = "${selectedDate.day.toString().padLeft(2, '0')}/"
                "${selectedDate.month.toString().padLeft(2, '0')}/"
                "${selectedDate.year}";
            _birthDateController.text = formattedDate;  // Update the controller with the formatted date
          }
        },
      ),
    ],
  );
}

}
