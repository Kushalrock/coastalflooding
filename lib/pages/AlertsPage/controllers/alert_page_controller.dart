import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sih2023/config/api_config.dart';

class AlertPageController extends GetxController {
  var loading = false.obs;

  var alerts = [].obs;

  getAlerts() async {
    loading.value = true;
    final res = await Dio().get(
      ApiConfig.predictHq,
      options: Options(
        headers: {
          'Authorization': 'Bearer 9kGNx3yHJNXi_90AgCm1__PYUGpYCKdji1QAtl9u',
        },
      ),
    );

    alerts.value = res.data["results"];
    loading.value = false;
  }
}
