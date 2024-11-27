import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';

class WelcomeScreenController extends GetxController {
  bool phoneMethod = false;
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void onForgotPasswordButtonTap() {
    Get.toNamed(AppPageNames.forgotPasswordScreen);
  }

  void onProfileButtonTap() {
    Get.toNamed(AppPageNames.profileScreen);
  }

  void onWalletButtonTap() {
    Get.toNamed(AppPageNames.walletScreen);
  }
}
