import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PostPageController extends GetxController {
  TextEditingController postController = TextEditingController();

  var pointsToAward = 0;

  var loading = false.obs;

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
    loading.value = false;
  }
}
