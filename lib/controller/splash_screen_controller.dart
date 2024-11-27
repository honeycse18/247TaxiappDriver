import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class SplashScreenController extends GetxController {
/*   Future<void> delayAndGotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppPageNames.introScreen);
  } */

  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */
  Future<void> delayAndGotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // Get.toNamed(AppPageNames.introScreen);
    Get.offNamedUntil(_pageRouteName, (_) => false);
  }

/* <---- Go to next page ----> */
  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      pageRouteName = AppPageNames.zoomDrawerScreen;
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

  void onInit() {
    // TODO: implement onInit
    delayAndGotoNextScreen();
    super.onInit();
  }
}
