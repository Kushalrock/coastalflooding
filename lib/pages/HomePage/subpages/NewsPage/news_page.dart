import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/pages/HomePage/controllers/news_controller.dart';
import 'package:sih2023/pages/HomePage/controllers/profile_controller.dart';
import 'package:sih2023/pages/HomePage/subpages/NewsPage/components/newscard.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.put(NewsController());
  final ProfileController _profileController = Get.put(ProfileController());
  final CarouselController _carouselController = CarouselController();
  final List<String> imageTexts = [
    'This Year forecast',
    'Five Years Forecast',
    'Ten Years Forecast',
    'Twenty Years Forecast',
    'Uptill 2050',
  ];
  int _currentImageIndex = 0;
  ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _profileController.initProfileData();
    _profileController.getAquaPoints();
    newsController.getNews();
  }
  // @override
  // void dispose() {
  //   _carouselController.dispose();
  //   super.dispose();
  // }

  List<Widget> getNewsWidget(int newsLength) {
    List<Widget> toReturn = [];
    for (int i = 0; i < newsLength; i++) {
      toReturn.add(
        CardHorizontal(
          title: newsController.news[i].title,
          desc: newsController.news[i].description,
          img: newsController.news[i].urlToImage,
          url: newsController.news[i].url,
          publishedAt: newsController.news[i].publishedAt,
        ),
      );
    }
    return toReturn;
  }

  Future fullPage(String location) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 2)),
        content: Container(
          height: 300, // 300
          width: 400, //400
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              location,
              fit: BoxFit.fitWidth, //cover or fill
            ),
          ),
        ),
        elevation: 2,
        actions: [
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          child: child,
          opacity: anim1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF4956CC)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/profile-img.png',
                          height: 100,
                          width: 100,
                        )),
                  ),
                  SizedBox(width: 30.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: Center(
                          child: Obx(
                            () => Text(
                              _profileController.name.value,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Obx(
                          () => Text(
                            _profileController.email.value,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: Colors.lightBlue,
                            size: 40,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              _profileController.aquapoints.value.toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              " (${_profileController.recentAquaPoints.value >= 0 ? '+' : ''}${_profileController.recentAquaPoints.value.toString()})",
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    _profileController.recentAquaPoints.value >=
                                            0
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                    _currentPageNotifier.value = index;
                  });
                },
              ),
              items: [
                InkWell(
                  onTap: () => fullPage('assets/images/yearforecast.png'),
                  child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/yearforecast.png',
                        fit: BoxFit.cover),
                  ),
                ),
                InkWell(
                  onTap: () => fullPage('assets/images/fiveyearforecast.png'),
                  child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/images/fiveyearforecast.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => fullPage('assets/images/tenyearforecast.png'),
                  child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/tenyearforecast.png',
                        fit: BoxFit.cover),
                  ),
                ),
                InkWell(
                  onTap: () => fullPage('assets/images/twentyyearforecast.png'),
                  child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/twentyyearforecast.png',
                        fit: BoxFit.cover),
                  ),
                ),
                InkWell(
                  onTap: () => fullPage('assets/images/forecast2050.png'),
                  child: Container(
                    height: 200,
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Image.asset('assets/images/forecast2050.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ],
              carouselController: _carouselController,
            ),
            SizedBox(height: 16.0),
            Card(
              child: ValueListenableBuilder<int>(
                valueListenable: _currentPageNotifier,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      imageTexts[value % imageTexts.length],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: getNewsWidget(newsController.news.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
