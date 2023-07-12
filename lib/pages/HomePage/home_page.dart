import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/constants/Theme.dart';
import 'package:sih2023/pages/HomePage/controllers/home_page_controller.dart';
import 'package:sih2023/pages/HomePage/controllers/news_controller.dart';
import 'package:sih2023/pages/HomePage/subpages/MonitoringPage/monitoringpage.dart';
import 'package:sih2023/pages/HomePage/subpages/NewsPage/news_page.dart';
import 'package:sih2023/pages/HomePage/subpages/ProfilePage/profile_page.dart';
import 'package:sih2023/pages/HomePage/subpages/QuizPage/quiz_page.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController homePageController = Get.put(HomePageController());
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home',
            style: TextStyle(
              color: NowUIColors.black,
            ),
          ),
        ),
        backgroundColor: NowUIColors.white,
      ),
      body: PageView(
        controller: _pageController,
        children: [NewsPage(), ProfilePage(), MonitoringPage(), QuizPage()],
      ),
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
            BarItem(
              filledIcon: Icons.map,
              outlinedIcon: Icons.map_outlined,
            ),
            BarItem(
              filledIcon: Icons.school,
              outlinedIcon: Icons.school_outlined,
            ),
          ],
          selectedIndex: homePageController.currentPage.value,
          onItemSelected: (int index) {
            homePageController.currentPage.value = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.linear);
          },
        ),
      ),
    );
  }
}
