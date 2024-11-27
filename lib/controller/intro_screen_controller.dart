import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/model/fakeModel/intro_content_model.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';

class IntroScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  IntroContent fakeIntroContent = FakeData.introContents.first;
  final PageController pageController = PageController(keepPage: false);
  int currentIndex = 0;
  Timer? _timer; // Timer for automatic sliding

  @override
  void onInit() {
    super.onInit();
    _startAutoSlide();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // Change duration as needed
      if (pageController.hasClients) {
        int nextPage = pageController.page!.toInt() + 1;
        if (nextPage >= FakeData.introContents.length) {
          nextPage = 0; // Loop back to the first page
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  /* <---- Go to next intro section ----> */
  void onContinueButtonTap() {
    // findAccount();
    Get.toNamed(AppPageNames.loginScreen);
    // Get.toNamed(AppPageNames.signUpScreen);
  }

  void gotoNextIntroSection(BuildContext context) {
    if (isLastPage) {
      Get.toNamed(AppPageNames.loginScreen);
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
    }
    update();
  }

  /*<----------- Go to previous intro section ----------->*/

  void gotoPreviousIntroSection(BuildContext context) {
    pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  bool get isFirstPage {
    try {
      return pageController.page == pageController.initialPage;
    } catch (e) {
      return true;
    }
  }

  bool get isLastPage {
    try {
      return pageController.page == (FakeData.introContents.length - 1);
    } catch (e) {
      return false;
    }
  }
}
