import 'package:get/get.dart';
import 'package:sih2023/pages/HomePage/controllers/monitoring_page_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class MonitoringPage extends StatefulWidget {
  MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  final MonitoringPageController monitoringPageController =
      Get.put(MonitoringPageController());

  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..enableZoom(true);

  @override
  void initState() {
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (url) {
          monitoringPageController.loading.value = false;
          controller.scrollBy(5000, 0);
        },
      ),
    );
    controller.loadRequest(Uri.parse(
        'https://sealevel.nasa.gov/ipcc-ar6-sea-level-projection-tool'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => monitoringPageController.loading.value == true
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
