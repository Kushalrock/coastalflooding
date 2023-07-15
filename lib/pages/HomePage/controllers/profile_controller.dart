import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var name = ''.obs;

  var aquapoints = 0.obs;
  var recentAquaPoints = 0.obs;

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

  getAquaPoints() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (data.data() == null || !data.data()!.containsKey('aqua_points')) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({"aqua_points": 0, "recent_aqua_points": 0},
              SetOptions(merge: true));
    } else {
      aquapoints.value = data.data()!['aqua_points'];
      recentAquaPoints.value = data.data()!['recent_aqua_points'];
    }
  }
}
