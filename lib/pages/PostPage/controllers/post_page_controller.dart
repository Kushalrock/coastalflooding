import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PostPageController extends GetxController {
  TextEditingController postController = TextEditingController();

  var pointsToAward = 0;

  var loading = false.obs;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  checkTextAwardPoints({var imageGiven = true}) {
    pointsToAward = 0;
    if (imageGiven) {
      pointsToAward += 10;
    }
    if (postController.text.contains('Singapore')) {
      pointsToAward += 10;
    }
    if (postController.text.contains('India')) {
      pointsToAward += 10;
    }
    if (postController.text.contains('Coastal')) {
      pointsToAward += 10;
    }
    if (postController.text.contains('Flooding')) {
      pointsToAward += 10;
    }
    if (postController.text.contains('Sea Rise')) {
      pointsToAward += 10;
    }
  }

  Future<String> uploadPhoto(File photo) async {
    final fileName = basename(photo.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      final task = await ref.putFile(photo);
      final url = await task.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('error occured');
      return "";
    }
  }

  uploadPost(File? photo) async {
    loading.value = true;
    var imgageUrl = "";
    if (photo != null) {
      imgageUrl = await uploadPhoto(photo);
      checkTextAwardPoints();
    }
    checkTextAwardPoints(imageGiven: false);
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(DateTime.now().toString())
        .set({
      "aquapoints": pointsToAward,
      "likes": 0,
      "owner-email": FirebaseAuth.instance.currentUser!.email,
      "owner": FirebaseAuth.instance.currentUser!.displayName,
      "img-url": imgageUrl,
      "content": postController.text,
    });
    final misc = await FirebaseFirestore.instance
        .collection('miscellanous')
        .doc("markerpoints")
        .get();
    var pos = await _determinePosition();
    var pointsArr = misc.data()!["points"];
    pointsArr.add("${pos.latitude} ${pos.longitude}");
    await FirebaseFirestore.instance
        .collection('miscellanous')
        .doc("markerpoints")
        .set({"points": pointsArr}, SetOptions(merge: true));
    final stuff = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (stuff.data() != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({"aqua_points": stuff.data()!["aqua_points"] + pointsToAward},
              SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({"aqua_points": pointsToAward}, SetOptions(merge: true));
    }
    loading.value = false;
  }
}
