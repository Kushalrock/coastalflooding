import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import '../../constants/Theme.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  void buildConversation() async {
    try {
      final conversationObject = {'appId': '30be6eb0deda2a6d0086acb9118f7b444'};
      final result =
          await KommunicateFlutterPlugin.buildConversation(conversationObject);
      print("Conversation builder success : " + result.toString());
    } on Exception catch (e) {
      print("Conversation builder error occurred : " + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    buildConversation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Center(
          child: Text(
            'Bot',
            style: TextStyle(
              color: NowUIColors.black,
            ),
          ),
        ),
        backgroundColor: NowUIColors.white,
      ),
    );
  }
}
