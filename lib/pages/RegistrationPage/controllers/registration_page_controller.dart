import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPageController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var loading = false.obs;

  Future<Map<String, dynamic>> signUp() async {
    loading.value = true;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await credential.user?.updateDisplayName(
          firstNameController.text + " " + lastNameController.text);
      loading.value = false;
      return {"success": true, "error": "None"};
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      return {"success": false, "error": e.code};
    } catch (e) {
      loading.value = false;
      return {"success": false, "error": e.toString()};
    }
  }
}
