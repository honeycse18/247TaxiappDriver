import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/find_account_response.dart';
import 'package:taxiappdriver/model/api_response/social_google_login_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_local_stored_keys.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/utils/helpers/social_auth.dart';

class LoginScreenController extends GetxController {
  bool phoneMethod = false;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  void onContinueButtonTap() {
    findAccount();

    // LoginPasswordScreen();
    // Get.toNamed(AppPageNames.logInPasswordScreen);
  }

  Future<void> findAccount() async {
    isLoading = true;
    String key = 'email';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    FindAccountResponse? response = await APIRepo.findAccount(requestBody);
    isLoading = false;

    if (response == null) {
      // Get.snackbar('Found Empty Response', response?.msg??'');
      APIHelper.onError(
          response?.msg ?? 'Found Empty Response from Remote Server');
      return;
    } else if (response.error) {
      APIHelper.onNewFailure('Found No Response', response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFindingAccount(response);
  }

  onSuccessFindingAccount(FindAccountResponse response) {
    bool hasAccount = response.data.account;
    log(response.data.role);
    if (hasAccount) {
      if (response.data.role == AppConstants.userRoleUser) {
        Get.toNamed(AppPageNames.loginPasswordScreen,
            arguments: SignUpScreenParameter(
                emailOrPhone: !phoneMethod
                    ? emailTextEditingController.text
                    : phoneTextEditingController.text,
                isEmail: !phoneMethod,
                theValue: phoneMethod
                    ? getPhoneFormatted()
                    : emailTextEditingController.text));
      } else {
        Get.snackbar(
            AppLanguageTranslation.alreadyRegisteredTranskey.toCurrentLanguage,
            AppLanguageTranslation
                .alreadyHaveAccountWithThisCredentialTranskey.toCurrentLanguage,
            backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
            overlayBlur: 2,
            snackStyle: SnackStyle.FLOATING,
            overlayColor: Colors.transparent);
        return;
      }
    } else {
      Get.toNamed(AppPageNames.signUpScreen,
          arguments: SignUpScreenParameter(
              emailOrPhone: !phoneMethod
                  ? emailTextEditingController.text
                  : phoneTextEditingController.text,
              isEmail: !phoneMethod,
              countryCode: currentCountryCode,
              theValue: phoneMethod
                  ? phoneTextEditingController.text
                  : emailTextEditingController.text));
    }
  }

  void onMethodButtonTap() {
    phoneMethod = !phoneMethod;
    update();
  }

  /* <---- Google Login Button Tap Action  ----> */

  void onGoogleSignButtonTap() async {
    final UserCredential? uc = await SocialAuth().signInWithGoogle();
    log(uc?.credential?.accessToken?.toString() ?? '');
    log(uc?.user?.uid.toString() ?? '');
    final idToken = await uc?.user?.getIdToken();
    log(idToken.toString());
    googleLogin(idToken ?? '');
  }
  /* <---- Google Login ----> */

  Future<void> googleLogin(String accessToken) async {
    final Map<String, Object> requestBody = {
      'access_token': accessToken,
      'role': 'driver',
      'country': '66c46da00f11b9a5a2165f99',
    };
    String requestBodyJson = jsonEncode(requestBody);
    SocialGoogleLoginResponse? response =
        await APIRepo.socialGoogleLoginVerify(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessGoogleLogin(response);
  }

  void _onSuccessGoogleLogin(SocialGoogleLoginResponse response) async {
    final String token =
        response.token.isNotEmpty ? response.token : response.data.token;
    await GetStorage().write(LocalStoredKeyName.loggedInDriverToken, token);
    _getLoggedInUserDetails(token);
  }
  /* <---- Get Logged User Details From Api----> */

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
      Get.offAllNamed(AppPageNames.zoomDrawerScreen);
      log('Login');
    }
  }

  // String getPhoneFormatted() {
  //   return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  // }

  // Future<void> findAccount() async {
  //   String key = 'email';
  //   String value = emailTextEditingController.text;
  //   if (phoneMethod) {
  //     key = 'phone';
  //     value = getPhoneFormatted();
  //   }
  //   final Map<String, dynamic> requestBody = {
  //     key: value,
  //   };
  //   FindAccountResponse? response = await APIRepo.findAccount(requestBody);
  //   if (response == null) {
  //     // Get.snackbar('Found Empty Response', response?.msg??'');
  //     APIHelper.onError(response?.msg ?? '');
  //     return;
  //   } else if (response.error) {
  //     APIHelper.onNewFailure(
  //         AppLanguageTranslation.foundNoResponseTranskey.toCurrentLanguage,
  //         response.msg);
  //     return;
  //   }
  //   log(response.toJson().toString());
  //   onSuccessFindingAccount(response);
  // }

  // onSuccessFindingAccount(FindAccountResponse response) {
  //   bool hasAccount = response.data.account;
  //   log(response.data.role);
  //   if (hasAccount) {
  //     if (response.data.role == AppConstants.userRoleUser) {
  //       Get.toNamed(AppPageNames.logInPasswordScreen,
  //           arguments: SignUpScreenParameter(
  //               isEmail: !phoneMethod,
  //               theValue: phoneMethod
  //                   ? getPhoneFormatted()
  //                   : emailTextEditingController.text));
  //     } else {
  //       Get.snackbar(
  //           AppLanguageTranslation.alreadyRegisteredTranskey.toCurrentLanguage,
  //           AppLanguageTranslation
  //               .alreadyHaveAccountWithThisCredentialTranskey.toCurrentLanguage,
  //           backgroundColor: AppColors.backgroundColor.withOpacity(0.5),
  //           overlayBlur: 2,
  //           snackStyle: SnackStyle.FLOATING,
  //           overlayColor: Colors.transparent);
  //       return;
  //     }
  //   } else {
  //     Get.toNamed(AppPageNames.registrationScreen,
  //         arguments: SignUpScreenParameter(
  //             isEmail: !phoneMethod,
  //             countryCode: currentCountryCode,
  //             theValue: phoneMethod
  //                 ? phoneTextEditingController.text
  //                 : emailTextEditingController.text));
  //   }
  // }

  void _getScreenParameters() {
    if (Get.arguments != null) {
      final SignUpScreenParameter parameter = Get.arguments;
      if (parameter.isEmail) {
        emailTextEditingController.text = parameter.emailOrPhone;
        phoneMethod = false;
      } else {
        phoneTextEditingController.text = parameter.emailOrPhone;
        currentCountryCode =
            parameter.countryCode ?? CountryCode.fromCountryCode('UK');
        phoneMethod = true;
      }
    }
    update();
  }
  // SocketController socketController=SocketController();

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
/*      try {
      // socketController = Get.find<SocketController>();
      socketController = Get.put<SocketController>(SocketController());
    } catch (e) {
      socketController = Get.put<SocketController>(SocketController());
    }
    socketController.initSocket(); */
    super.onInit();
  }
}
