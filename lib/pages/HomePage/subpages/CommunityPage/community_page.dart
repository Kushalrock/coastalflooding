import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

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
        return ListView(
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
                                  width: 150,
                                ),
                                TextButton.icon(
                                    onPressed: () {},
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
        );
      },
    );
  }
}
