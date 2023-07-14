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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/profile-img.png',
                          height: 100,
                          width: 100,
                        )),
                  ),
                  SizedBox(width: 50.0),
                  Column(
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop,
                            color: Colors.lightBlue,
                            size: 40,
                          ),
                          Obx(
                            () => Text(
                              _profileController.aquapoints.value.toString(),
                              style: TextStyle(
                                fontSize: 18,
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
                ],
              ),
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
                Container(
                  height: 200,
                  width: 330,
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/yearforecast.png',
                      fit: BoxFit.cover),
                ),
                Container(
                  height: 200,
                  width: 330,
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/fiveyearforecast.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  width: 330,
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/tenyearforecast.png',
                      fit: BoxFit.cover),
                ),
                Container(
                  height: 200,
                  width: 330,
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/twentyyearforecast.png',
                      fit: BoxFit.cover),
                ),
                Container(
                  height: 200,
                  width: 330,
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/forecast2050.png',
                      fit: BoxFit.cover),
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
