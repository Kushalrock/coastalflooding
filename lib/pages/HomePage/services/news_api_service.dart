import 'package:sih2023/config/api_config.dart';
import 'package:sih2023/config/dio_service.dart';

class NewsAPIService {
  static Future<Map<String, dynamic>> getNews() async {
    try {
      var resp = await DioService.dio.getUri(Uri.parse(ApiConfig.newsApiGet));
      return {"success": true, "articles": resp.data["articles"]};
    } on Exception catch (e) {
      // TODO
      return {"success": false, "articles": []};
    }
  }
}
