import 'package:flutter/material.dart';
import 'package:app_banksampah/pages/welcome/welcome.dart';
import 'package:app_banksampah/pages/signup/fields/body.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const HomePage(),
                  ),
                );
              }),
          backgroundColor: const Color.fromARGB(255, 76, 202, 120),
          title: const Text("SIGNUP"),
        ),
        body: Body());
  }
}
