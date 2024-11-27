import 'dart:async';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/otp_request_response.dart';
import 'package:taxiappdriver/model/api_response/otp_verification_response.dart';
import 'package:taxiappdriver/model/api_response/registration_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_local_stored_keys.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class VerificationScreenController extends GetxController {
  final bool shouldShowLoadingIndicator = false;
  TextEditingController otpInputTextController = TextEditingController();
  Map<String, dynamic> theData = {};
  Map<String, dynamic> resendCodeForgotPass = {};
  bool isEmail = true;
  bool isForRegistration = true;
  bool isOtpError = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  Duration otpTimerDuration = const Duration(seconds: 120);
  Timer? otpTimer;

  final GetStorage _storage = GetStorage();

  _resetTimer() {
    otpTimerDuration = const Duration(seconds: 120);
  }

  Future<void> onSendCodeButtonTap() async {
    await sendCode();
  }

  void onResendButtonTap() {
    if (isDurationOver()) {
      resendCode();
      otpInputTextController.clear();
    } else {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .pleaseWaitFewMoreSecondTransKey.toCurrentLanguage);
    }
  }

  Future<void> sendCode() async {
    isLoading = true;
    theData['otp'] = otpInputTextController.text;
    if (isForRegistration) {
      RegistrationResponse? response = await APIRepo.registration(theData);
      isLoading = false;
      if (response == null || response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      log(response.toJson().toString());
      onSuccessResponse(response);
    } else {
      OtpVerificationResponse? response = await APIRepo.verifyOTP(theData);
      isLoading = false;
      if (response == null || response.error) {
        isOtpError = true;
        update();
        return;
      }
      isOtpError = false;
      log(response.toJson().toString());
      onSuccessGettingOtpVerified(response);
    }
  }

  onSuccessGettingOtpVerified(OtpVerificationResponse response) {
    Get.offNamed(AppPageNames.createNewPasswordScreen,
        arguments: response.data.token);
  }

  Future<void> resendCode() async {
    isLoading = true;
    if (isForRegistration) {
      Map<String, dynamic> requestBody = {
        'phone': theData['phone'],
        'email': theData['email'],
        'action': 'registration',
      };
      OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
      isLoading = false;
      isOtpError = false;

      if (response == null) {
        // AppDialogs.showErrorDialog(
        //     messageText: AppLanguageTranslation
        //         .noResponseForResendingCodeTranskey.toCurrentLanguage);
        return;
      } else if (response.error) {
        log(response.msg);
        AppDialogs.showErrorDialog(messageText: response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessResendCode();
    } else {
      OtpRequestResponse? response =
          await APIRepo.requestOTP(resendCodeForgotPass);
      isLoading = false;

      if (response == null) {
        // AppDialogs.showErrorDialog(
        //     messageText: AppLanguageTranslation
        //         .noResponseForthisOperationTranskey.toCurrentLanguage);
        return;
      } else if (response.error) {
        // AppDialogs.showErrorDialog(messageText: response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessSendingOTP(response);
    }
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    /* AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.codeHasBeenResentTranskey.toCurrentLanguage); */
    Get.snackbar('Otp Sent Successfully', 'Otp code has been sent successfully',
        snackPosition: SnackPosition.TOP);
    _resetTimer();
  }

  void onSuccessResendCode() {
    /* AppDialogs.showSuccessDialog(
        messageText: 'Otp code has been sent successfully'); */

    Get.snackbar('Otp Sent Successfully', 'Otp code has been sent successfully',
        snackPosition: SnackPosition.TOP);

    _resetTimer();
  }

  void onSuccessResponse(RegistrationResponse response) {
    fetchUserDetails(response.data.token);
  }

  Future<void> fetchUserDetails(String token) async {
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    getLoggedInUserDetails(token);
  }

  Future<void> getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
      // Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
    }
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is Map<String, dynamic>) {
      theData = argument;
      isEmail = theData['isEmail'];
      isForRegistration = theData['isForRegistration'];
      theData.remove('isEmail');
      theData.remove('isForRegistration');
    }
    update();
    if (!isForRegistration) {
      resendCodeForgotPass = theData['resendCode'];
      theData.remove('resendCode');
      update();
    }
    resendCode();
  }

  void _startTimer() {
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
        _storage.write('otpTimerDuration', otpTimerDuration.inSeconds);
      }
      update();
    });
  }

  @override
  void onInit() {
    _getScreenParameter();
    int? storedDuration = _storage.read('otpTimerDuration');
    if (storedDuration != null && storedDuration > 0) {
      otpTimerDuration = Duration(seconds: storedDuration);
    } else {
      otpTimerDuration = const Duration(seconds: 120);
    }
    _startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    if (otpTimer?.isActive ?? false) {
      otpTimer?.cancel();
    }
    super.dispose();
  }

  void onBackButtonPressed() {
    Get.back();
  }
}
