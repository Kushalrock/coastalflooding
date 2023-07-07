import 'package:get/get.dart';
import 'package:sih2023/models/news_model.dart';
import 'package:sih2023/pages/HomePage/services/news_api_service.dart';

class NewsController extends GetxController {
  var news = [].obs;

  void getNews() async {
    var resp = await NewsAPIService.getNews();
    if (resp['success'] == true) {
      for (var article in resp['articles']) {
        final NewsModel newsModel = NewsModel(
          title: article['title'],
          url: article['url'],
          description: article['content'].toString().substring(0, 60),
          urlToImage: article['urlToImage'] == null
              ? "https://149487864.v2.pressablecdn.com/wp-content/uploads/2021/09/News-Placeholder.png"
              : article['urlToImage'],
          publishedAt: article["publishedAt"],
        );
        news.add(newsModel);
      }
    }
  }
}
