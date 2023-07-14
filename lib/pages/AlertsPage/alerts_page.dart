import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sih2023/pages/AlertsPage/controllers/alert_page_controller.dart';
import '../../constants/Theme.dart';

class AlertsPage extends StatefulWidget {
  AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  getIcons(List<String>? arr) {
    if (arr == null) return;
    List<Widget> toReturn = [];
    if (arr.contains('storm')) {
      toReturn.add(
        Icon(
          Icons.storm,
          size: 30,
        ),
      );
    }
    if (arr.contains('flood')) {
      toReturn.add(Icon(
        Icons.flood,
        size: 30,
        color: Colors.lightBlue,
      ));
    }
    if (arr.contains('disaster')) {
      toReturn.add(Icon(
        Icons.dangerous,
        size: 30,
        color: Colors.red,
      ));
    }
    if (arr.contains('fire')) {
      toReturn.add(Icon(
        Icons.fireplace,
        size: 30,
        color: Color.fromARGB(255, 255, 106, 0),
      ));
    }
    return toReturn;
  }

  List<Widget> getAlertCards(int i) {
    List<Widget> toReturn = [];
    for (int j = 0; j < i; j++) {
      toReturn.add(
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  alertPageController.alerts.value[j]["title"],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getIcons(
                    (alertPageController.alerts.value[j]["labels"] as List)
                        .map((item) => item as String)
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'CAP ALERT RANK: ${alertPageController.alerts.value[j]["rank"]}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        alertPageController.alerts.value[j]["location"][1],
                        alertPageController.alerts.value[j]["location"][0],
                      ),
                      zoom: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return toReturn;
  }

  final AlertPageController alertPageController =
      Get.put(AlertPageController());

  @override
  void initState() {
    alertPageController.getAlerts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: NowUIColors.white,
        title: Center(
          child: Text(
            'Critical Alerts',
            style: TextStyle(
              color: NowUIColors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: alertPageController.loading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: getAlertCards(alertPageController.alerts.length),
                  ),
          ),
        ),
      ),
    );
  }
}
