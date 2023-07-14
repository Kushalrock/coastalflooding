import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sih2023/pages/PostPage/controllers/post_page_controller.dart';

import '../../constants/Theme.dart';

class PostPage extends StatefulWidget {
  PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostPageController postPageController = Get.put(PostPageController());

  File? _photo;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: NowUIColors.white,
        title: Center(
          child: Text(
            'CREATE POST',
            style: TextStyle(
              color: NowUIColors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/profile-img.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              TextField(
                maxLength: 500,
                maxLines: 10,
                controller: postPageController.postController,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    icon: Icon(
                      Icons.attach_file,
                    ),
                  ),
                  Text(
                    'Share Image',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Obx(
                    () => postPageController.loading.value == true
                        ? CircularProgressIndicator()
                        : Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  postPageController.uploadPost(_photo);
                                },
                                icon: Icon(
                                  Icons.post_add,
                                ),
                              ),
                              Text(
                                'Post content',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _photo != null
                  ? Image.file(
                      _photo!,
                      width: 400,
                      height: 400,
                      fit: BoxFit.fitHeight,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
