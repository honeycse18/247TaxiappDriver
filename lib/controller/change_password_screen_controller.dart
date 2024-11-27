import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/otp_request_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class ChangePasswordCreateController extends GetxController {
  /*<----------- Initialize variables ----------->*/

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  RxBool toggleHideOldPassword = true.obs;
  RxBool toggleHideNewPassword = true.obs;

  RxBool toggleHideConfirmPassword = true.obs;

  bool isPasswordOver8Characters = false;

  bool isPasswordHasAtLeastSingleNumberDigit = false;

  TextEditingController newPassword1EditingController = TextEditingController();
  TextEditingController currentPasswordEditingController =
      TextEditingController();
  TextEditingController newPassword2EditingController = TextEditingController();
  Map<String, dynamic> credentials = {};
  bool isEmail = false;
  SignUpScreenParameter? screenParameter;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));
  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword2EditingController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPasswordTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword1EditingController.text) {
        return AppLanguageTranslation
            .passwordDoesnotMatchTranskey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  /// Check password
  void passwordCheck(String passwordText) {
    if (passwordText.length > 7) {
      isPasswordOver8Characters = true;
      if (detectPasswordNumber(passwordText)) {
        isPasswordHasAtLeastSingleNumberDigit = true;
      } else {
        isPasswordHasAtLeastSingleNumberDigit = false;
      }
    } else {
      isPasswordOver8Characters = false;
    }
  }

  bool passMatched() {
    return newPassword1EditingController.text ==
        newPassword2EditingController.text;
  }

  void onSavePasswordButtonTap() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (passMatched()) {
        isLoading = true;
        sendPass();
      } else {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .passwordDoesnotMatchTranskey.toCurrentLanguage);
      }
    }
  }
  /*<----------- Send password for changing old password ----------->*/

  Future<void> sendPass() async {
    final Map<String, dynamic> requestBody = {
      'old_password': currentPasswordEditingController.text,
      'new_password': newPassword1EditingController.text,
      'confirm_password': newPassword2EditingController.text,
    };
    RawAPIResponse? response = await APIRepo.updatePassword(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onError(response.msg);
      return;
    }
    onSuccessSavePassword(response);
    isLoading = false;
  }

  void onSuccessSavePassword(RawAPIResponse response) {
    BuildContext? context = Get.context;
    if (context != null) {
      AppDialogs.showSuccessDialog(messageText: response.msg);
    }
  }

  void onForgotPasswordButtonTap() {
    forgotPassword();
  }

  /*<----------- Forgot password ----------->*/

  Future<void> forgotPassword() async {
    String key = 'phone';
    String value = '';
    if (isEmail) {
      value = credentials['email'];
      key = 'email';
    } else {
      value = credentials['phone'];
    }
    Map<String, dynamic> requestBody = {
      key: value,
      'action': 'forgot_password'
    };
    OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }

    _onSuccessSendingOTP(response, value, requestBody);
  }

  void _onSuccessSendingOTP(OtpRequestResponse response, String data,
      Map<String, dynamic> requestBody) {
    Map<String, dynamic> forgetPasswordData = {
      // 'theData': data,
      'isEmail': screenParameter!.isEmail ? true : false,
      'isForRegistration': false,
      'action': 'forgot_password',
      'resendCode': requestBody
    };
    if (isEmail) {
      forgetPasswordData["email"] = data;
    } else {
      forgetPasswordData["phone"] = data;
    }
    Get.offNamed(AppPageNames.verificationScreen,
        arguments: forgetPasswordData);
  }

  void onDispose() {
    newPassword1EditingController.dispose();
    newPassword2EditingController.dispose();
    currentPasswordEditingController.dispose();
  }
/* <---- Initial state ----> */

  @override
  void onInit() {
    newPassword1EditingController = TextEditingController();
    newPassword1EditingController.addListener(() {
      passwordCheck(newPassword1EditingController.text);
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    onDispose();

    super.onClose();
  }
}
