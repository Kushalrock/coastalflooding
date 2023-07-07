import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/pages/HomePage/controllers/home_page_controller.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => WaterDropNavBar(
          bottomPadding: 10,
          barItems: [
            BarItem(
              filledIcon: Icons.public,
              outlinedIcon: Icons.public_outlined,
            ),
            BarItem(
              filledIcon: Icons.person_2,
              outlinedIcon: Icons.person_2_outlined,
            ),
          ],
          selectedIndex: homePageController.currentPage.value,
          onItemSelected: (int index) {
            homePageController.currentPage.value = index;
          },
        ),
      ),
    );
  }
}
