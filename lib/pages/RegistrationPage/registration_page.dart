import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/pages/RegistrationPage/controllers/registration_page_controller.dart';

import '../../components/input.dart';
import '../../constants/Theme.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _checkboxValue = false;

  final double height = window.physicalSize.height;
  final RegistrationPageController registrationPageControler =
      Get.put(RegistrationPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Register',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: NowUIColors.black,
              ),
            ),
          ),
          backgroundColor: NowUIColors.bgColorScreen,
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/register-bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16.0, right: 16.0, bottom: 32),
                  child: Card(
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.78,
                            color: NowUIColors.bgColorScreen,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24.0, bottom: 8),
                                      child: Center(
                                          child: Text("Register",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Input(
                                            placeholder: "First Name...",
                                            prefixIcon:
                                                Icon(Icons.abc, size: 20),
                                            controller:
                                                registrationPageControler
                                                    .firstNameController,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Input(
                                            placeholder: "Last Name...",
                                            prefixIcon:
                                                Icon(Icons.abc, size: 20),
                                            controller:
                                                registrationPageControler
                                                    .lastNameController,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 8.0),
                                          child: Input(
                                            placeholder: "Your Email...",
                                            prefixIcon:
                                                Icon(Icons.mail, size: 20),
                                            controller:
                                                registrationPageControler
                                                    .emailController,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 0),
                                          child: Input(
                                            textInputType:
                                                TextInputType.visiblePassword,
                                            obscureText: true,
                                            placeholder: "Password...",
                                            prefixIcon:
                                                Icon(Icons.lock, size: 20),
                                            controller:
                                                registrationPageControler
                                                    .passwordController,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 0, bottom: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                  activeColor:
                                                      NowUIColors.primary,
                                                  onChanged: (bool? newValue) =>
                                                      setState(
                                                        () {
                                                          if (newValue !=
                                                              null) {
                                                            _checkboxValue =
                                                                newValue;
                                                          }
                                                        },
                                                      ),
                                                  value: _checkboxValue),
                                              Text(
                                                  "I agree with the terms and conditions",
                                                  style: TextStyle(
                                                      color: NowUIColors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Obx(
                                        () => registrationPageControler
                                                .loading.value
                                            ? CircularProgressIndicator()
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      NowUIColors.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                ),
                                                onPressed: _checkboxValue ==
                                                        false
                                                    ? null
                                                    : () async {
                                                        final resp =
                                                            await registrationPageControler
                                                                .signUp();
                                                        if (resp["success"] ==
                                                            true) {
                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context,
                                                                  '/home');
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                resp['error'],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 32.0,
                                                      right: 32.0,
                                                      top: 12,
                                                      bottom: 12),
                                                  child: Text(
                                                    "Get Started",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: NowUIColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      )),
                ),
              ]),
            )
          ],
        ));
  }
}
