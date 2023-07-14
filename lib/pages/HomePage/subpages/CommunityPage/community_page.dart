import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool loading = false;
  bool showImage = false;

  showAquaImage() {
    setState(() {
      showImage = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showImage = false;
      });
    });
  }

  Future<Map<String, dynamic>> donateAquaPoints(String emailToDonateTo) async {
    setState(() {
      loading = true;
    });
    var toReturn = {"success": true, "error": "None"};
    final stuff = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();

    if (stuff.data() == null || !stuff.data()!.containsKey("aqua_points")) {
      toReturn["success"] = false;
      toReturn["error"] = "Earn More Aqua Points by interacting!";
    } else {
      var aquapoints = stuff.data()!["aqua_points"];

      if (aquapoints >= 10) {
        final refOfOtherUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(emailToDonateTo)
            .get();
        if (refOfOtherUser.data() != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(emailToDonateTo)
              .set({"aqua_points": refOfOtherUser.data()!["aqua_points"] + 10},
                  SetOptions(merge: true));
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(emailToDonateTo)
              .set({"aqua_points": 10}, SetOptions(merge: true));
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .set({"aqua_points": aquapoints - 10}, SetOptions(merge: true));
      } else {
        toReturn["success"] = false;
        toReturn["error"] = "Earn More Aqua Points by interacting!";
      }
    }
    setState(() {
      loading = false;
    });
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          children: [
            ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                document.data()['owner'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                              document.data()['content'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              bottom: 10,
                              top: 10,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            child: document.data()['img-url'].toString().isEmpty
                                ? SizedBox()
                                : Image.network(
                                    document.data()['img-url'],
                                  ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${document.data()['likes']}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.heart_broken_rounded,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "${document.data()['aquapoints']}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      width: 115,
                                    ),
                                    TextButton.icon(
                                        onPressed: loading
                                            ? null
                                            : () async {
                                                var result =
                                                    await donateAquaPoints(
                                                  document
                                                      .data()['owner-email'],
                                                );
                                                if (result["success"] ==
                                                    false) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        result["error"],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  showAquaImage();
                                                }
                                              },
                                        icon: Icon(
                                          Icons.water_drop_rounded,
                                          color: Colors.lightBlue,
                                        ),
                                        label: Text('Donate'))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (showImage)
              Container(
                child: Center(
                  child: Image.asset(
                    "assets/images/waterdrop-image-thumbs-up.jpg",
                    height: 100,
                    width: 100,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.height * 0.8,
                color: Color.fromARGB(29, 0, 0, 0),
              ),
          ],
        );
      },
    );
  }
}
