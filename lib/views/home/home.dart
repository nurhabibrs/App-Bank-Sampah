import 'package:app_banksampah/views/welcome/welcome.dart';

import '../../extensions/hidden_keyboard.dart';
import '../../views/home/fields/background.dart';
import 'package:dio/dio.dart';
import '../../services/user_api_auth.dart';
import 'package:flutter/material.dart';
import '../../extensions/rounded_button.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiServices _apiServices = ApiServices();

  Future<Map<String, dynamic>> getUserData() async {
    dynamic userRes;
    userRes = await _apiServices.getUserProfileData(widget.token);
    return userRes;
  }

  Future<void> logout() async {
    await _apiServices.logout(widget.token);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CoverScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: HiddenKeyboard(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: FutureBuilder<Map<String, dynamic>>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: size.height,
                        width: size.width,
                        // color: Colors.blueGrey,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    String username =
                        snapshot.data!["response"]["user_info"]["username"];
                    String fullname =
                        snapshot.data!["response"]["user_info"]["fullname"];
                    String address =
                        snapshot.data!["response"]["user_info"]["address"];
                    String phone =
                        snapshot.data!["response"]["user_info"]["phone"];
                    String email =
                        snapshot.data!["response"]["user_info"]["email"];

                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 50, 205, 50),
                                    border: Border.all(
                                        width: 3, color: Colors.blue),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Image(
                                        image: AssetImage(
                                            'assets/images/trash.png'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  username,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Color.fromARGB(255, 50, 205, 50),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  fullname,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 50, 205, 50),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text('DETAIL PROFIL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 130, 241, 130),
                                  borderRadius: BorderRadius.circular(10),
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Full Name:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(fullname,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 130, 241, 130),
                                  borderRadius: BorderRadius.circular(10),
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Alamat:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(address,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 130, 241, 130),
                                  borderRadius: BorderRadius.circular(10),
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Nomor Telepon:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(phone,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 130, 241, 130),
                                  borderRadius: BorderRadius.circular(15),
                                  // border:
                                  //     Border.all(width: 1, color: Colors.black),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Email:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(email,
                                        style: const TextStyle(
                                            fontSize: 19, color: Colors.black)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () async {
                                  await _apiServices.logout(widget.token);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CoverScreen()));
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.redAccent.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 25)),
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    debugPrint(snapshot.error.toString());
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
