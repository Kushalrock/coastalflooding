import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/pages/HomePage/controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    _profileController.initProfileData();
    super.initState();
  }

  List<FlSpot> getSpotList() {
    List<FlSpot> flspots = [];
    var dates = _profileController.chartData.keys.toList();
    var points = _profileController.chartData.values.toList();

    for (int i = 0; i < dates.length; i++) {
      flspots.add(
        FlSpot(
          i.toDouble(),
          points[i].toDouble(),
        ),
      );
    }

    return flspots;
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = _profileController.chartData.keys.toList()[0];
              break;
            case 1:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
            case 2:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
            case 3:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
            case 4:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
            case 5:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
            case 6:
              text = _profileController.chartData.keys.toList()[value.toInt()];
              break;
          }

          return Text(text);
        },
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            child: Center(
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5.0,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  _profileController.name.value,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Obx(
              () => Text(
                _profileController.email.value,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 150,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'AquaPoints',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: Colors.lightBlue,
                          size: 100,
                        ),
                        Obx(
                          () => Text(
                            _profileController.aquapoints.value.toString(),
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                        ),
                        Text(
                          "(+20)",
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            'Points Graph',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(width: 1),
                      bottom: BorderSide(width: 1),
                    ),
                  ),
                  groupsSpace: 10,
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(
                          fromY: 0,
                          toY: 20,
                          width: 15,
                          color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(
                          fromY: 0,
                          toY: 20,
                          width: 15,
                          color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(
                          fromY: 0,
                          toY: 10,
                          width: 15,
                          color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 0, width: 15, color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(
                          fromY: 0, toY: 0, width: 15, color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(
                          fromY: 0,
                          toY: 30,
                          width: 15,
                          color: Colors.lightBlue),
                    ]),
                    BarChartGroupData(x: 7, barRods: [
                      BarChartRodData(
                          fromY: 0,
                          toY: 30,
                          width: 15,
                          color: Colors.lightBlue),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sea level rise and destruction of water resources as glaciers melt alone may have horrendous human consequences.',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '- Noah Chomsky',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
