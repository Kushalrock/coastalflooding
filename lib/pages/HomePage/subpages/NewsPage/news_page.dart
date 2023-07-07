import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sih2023/pages/HomePage/controllers/news_controller.dart';
import 'package:sih2023/pages/HomePage/subpages/NewsPage/components/newscard.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.put(NewsController());
  @override
  void initState() {
    super.initState();
    newsController.getNews();
  }

  List<Widget> getNewsWidget(int newsLength) {
    List<Widget> toReturn = [];
    for (int i = 0; i < newsLength; i++) {
      toReturn.add(
        CardHorizontal(
          title: newsController.news[i].title,
          desc: newsController.news[i].description,
          img: newsController.news[i].urlToImage,
          tap: () {
            launchUrlString(newsController.news[i].url);
          },
          publishedAt: newsController.news[i].publishedAt,
        ),
      );
    }
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: getNewsWidget(newsController.news.length),
        ),
      ),
    );
  }
}
