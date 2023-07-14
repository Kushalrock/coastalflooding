import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import '../../constants/Theme.dart';

class DevPage extends StatefulWidget {
  DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  var loading = true;

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..enableZoom(true);

  @override
  void initState() {
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            loading = false;
          });
          controller.scrollBy(5000, 0);
        },
      ),
    );
    controller.loadRequest(Uri.parse(
        'https://www.kaggle.com/code/agrkushal/global-sea-level-rise'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Dev Resources',
          style: TextStyle(
            color: NowUIColors.black,
          ),
        ),
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
