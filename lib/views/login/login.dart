import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../extensions/hidden_keyboard.dart';
import '../../extensions/rounded_button.dart';
import '../home/home.dart';
import 'background.dart';

class LoginScreen extends StatefulWidget {
  static const nameRoute = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPopCallback(BuildContext context) async {
    Navigator.of(context).pop();
    return true;
  }

  Widget _buildUsernameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerUsername,
      validator: (value) => _checkUsername(value),
      maxLength: 255,
      decoration: const InputDecoration(
        hintText: "Username",
        labelText: "Username",
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controllerPassword,
      obscureText: _obscureText,
      validator: (value) => _checkPassword(value),
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(15),
            right: Radius.circular(15),
          ),
        ),
      ),
    );
  }

  String? _checkUsername(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 3) {
      return 'Minimal 3 karakter';
    }
    return null;
  }

  String? _checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'Tidak boleh kosong.';
    }
    if (value.length < 8) {
      return 'Minimal 8 karakter';
    }
    return null;
  }

  Future _loginUser() async {
    var dio = Dio();

    var formData = FormData.fromMap(
      {
        'username': _controllerUsername.text,
        'password': _controllerPassword.text
      },
    );

    try {
      // Check response
      await dio
          .post('https://345d-103-23-224-196.ap.ngrok.io/login', data: formData)
          .then(
        (response) {
          String token = response.data["response"]["token"];
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(token: token),
            ),
          );
        },
      );
    } on DioError catch (err) {
      // Error message Pop Up
      String? _errorMessage = err.response?.data["response"].toString();

      AlertDialog alert = AlertDialog(
        title: const Text("Login Gagal!"),
        content: Text("$_errorMessage"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      // print(_errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenKeyboard(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => _onWillPopCallback(context),
          child: Background(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 45,
                      child: Text(
                        "LOGIN PENGGUNA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: _buildUsernameField(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 40),
                      child: _buildPasswordField(),
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _loginUser();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: const Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 50, 205, 50),
                            ),
                          ),
                          onPressed: () {
                            //Navigate to page forgot password
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const RegisterScreen(),
                            //   ),
                            // );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
