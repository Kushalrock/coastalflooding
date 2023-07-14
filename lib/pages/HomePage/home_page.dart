import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:sih2023/constants/Theme.dart';
import 'package:sih2023/pages/HomePage/controllers/home_page_controller.dart';
import 'package:sih2023/pages/HomePage/controllers/news_controller.dart';
import 'package:sih2023/pages/HomePage/subpages/CommunityPage/community_page.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: NowUIColors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/post');
            },
            child: Text('POST'),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/heatmap');
            },
            icon: Icon(
              Icons.map,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/alert');
            },
            icon: Icon(
              Icons.notifications,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
              buildConversation();
            },
            icon: Icon(
              Icons.chat_bubble,
              color: Colors.lightBlue,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/dev');
            },
            icon: Icon(
              Icons.developer_board,
              color: Colors.blueGrey,
            ),
          )
        ],
        backgroundColor: NowUIColors.white,
      ),
      body: PageView(
        controller: _pageController,
        children: [NewsPage(), CommunityPage(), MonitoringPage(), QuizPage()],
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
              filledIcon: Icons.people_alt,
              outlinedIcon: Icons.people_alt_outlined,
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
