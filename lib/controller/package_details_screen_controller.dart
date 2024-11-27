import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_history_response.dart';

class PackageDetailsScreenController extends GetxController {
  SubscriptionHistory subscription = SubscriptionHistory.empty();

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is SubscriptionHistory) {
      subscription = params;
      update();
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();

    super.onInit();
  }
}
