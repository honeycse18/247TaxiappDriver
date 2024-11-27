import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/login_response.dart';
import 'package:taxiappdriver/model/api_response/otp_request_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_local_stored_keys.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class LogInPasswordSCreenController extends GetxController {
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  bool phoneMethod = false;
  String emailOrPhone = '';
  RxBool toggleHidePassword = true.obs;
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  SignUpScreenParameter? screenParameter;
  Map<String, dynamic> credentials = {};
  bool isEmail = false;

  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onLoginButtonTap() async {
    /* Get.toNamed(AppPageNames.signUpScreen); */
    if (passwordFormKey.currentState?.validate() ?? false) {
      isLoading = true;
      await login();
      isLoading = false;
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
    /* OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    } */
    // log(response.toJson().toString());
    _onSuccessSendingOTP(value, requestBody);
  }

  void _onSuccessSendingOTP(String data, Map<String, dynamic> requestBody) {
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

  Future<void> login() async {
    credentials['password'] = passwordTextEditingController.text;
    final String? fcmToken = await Helper.getFCMToken;
    if (fcmToken != null) {
      credentials['fcm_token'] = fcmToken;
    }
    LoginResponse? response = await APIRepo.login(credentials);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure('You Have Entered Wrong Password');

      return;
    }
    log(response.toJson().toString());
    _onSuccessLogin(response);
  }

  Future<void> _onSuccessLogin(LoginResponse response) async {
    final token = response.data.token;
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    _getLoggedInUserDetails(token);
  }

  Future<void> _getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGetLoggedInUserDetails(response);
  }

  void _onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      // Get.toNamed(AppPageNames.unknownPage);
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    }
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      emailOrPhone = params.emailOrPhone;
      String key = 'phone';
      if (screenParameter!.isEmail) {
        key = 'email';
        isEmail = true;
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode =
            screenParameter!.countryCode ?? CountryCode.fromCountryCode('GB');
      }
      credentials[key] = screenParameter!.theValue;
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }

  @override
  void onClose() {
    passwordTextEditingController.dispose();
    emailTextEditingController.dispose();
    phoneTextEditingController.dispose();

    super.onClose();
  }
}
