import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class CreateNewPasswordScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
  ///
  RxBool toggleHidePassword = true.obs;
  String token = '';
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != confirmPasswordTextEditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }
    String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != passwordTextEditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  void onSavePasswordButtonTap() {
    if (passwordTextEditingController.text.isEmpty ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .eitherFieldEmptyPasswordsdonnotMassTranskey.toCurrentLanguage);
      return;
    }
    createNewPass();
  }
// /* <---- Create new password ----> */

  Future<void> createNewPass() async {
    Map<String, dynamic> requestBody = {
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      'token': token
    };
    isLoading = true;
    RawAPIResponse? response = await APIRepo.createNewPassword(requestBody);
    isLoading = false;

    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessChangingPassword(response);
  }

  onSuccessChangingPassword(RawAPIResponse response) async {
    await /* AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .passwordChangedSuccessfullyTransKey.toCurrentLanguage) */
        AppDialogs.showSuccessDialog(
            messageText:
                'Your account is complete. Please enjor the best menu from us.',
            titleText: 'Congratulation!');

    Get.offNamed(AppPageNames.loginScreen);
  }
// /*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      token = params;
    }
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }
}
