import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var name = ''.obs;

  var aquapoints = 100.obs;

  var chartData = {
    "04-07": 20,
    "05-07": 20,
    "06-07": 10,
    "07-07": 0,
    "08-07": 0,
    "09-07": 30,
    "10-07": 20,
  };

  initProfileData() {
    email.value = FirebaseAuth.instance.currentUser!.email!;
    name.value = FirebaseAuth.instance.currentUser!.displayName!;
  }
}
