import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/country_list_response.dart';
import 'package:taxiappdriver/model/api_response/otp_request_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class SignUpScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String? selectedGender;
  UserDetailsCountry? selectedCountry;
  List<UserDetailsCountry> countryList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  String emailOrPhone = '';
  final RxBool isDropdownOpen = false.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  RxBool toggleHidePassword = true.obs;

  bool isFieldFillupped() {
    return signUpFormKey.currentState?.validate() ?? false;
  }

  RxBool isGenderDropdownOpen = false.obs;
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectGender(String gender) {
    selectedGender = gender;
    isDropdownOpen.value = false;
  }

  Widget countryElementsList(int index, UserDetailsCountry country) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            country.code,
            height: 40,
            width: 40,
            shape: RoundedRectangle(10),
          ),
          AppGaps.wGap15,
          Expanded(
              child: Text(
            country.name,
            style: AppTextStyles.bodyBoldTextStyle,
          ))
        ],
      ),
    );
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
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

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    if (isFieldFillupped()) {
      toggleAgreeTermsConditions.value = value ?? false;
    }
    update();
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }
/* <---- Continue button tap ----> */

  void onContinueButtonTap() {
    // Get.toNamed(AppPageNames.verificationScreen);

    if (signUpFormKey.currentState?.validate() ?? false) {
      if (!toggleAgreeTermsConditions.value) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .youMustAgreeTermsConditionsFirstTranskey.toCurrentLanguage);
        return;
      }
      /* String key = 'phone';
      String value = getPhoneFormatted();
      if (isEmail) {
        key = 'email';
        value = emailTextEditingController.text;
      }
      Map<String, dynamic> requestBodyForOTP = {
        key: value,
        'action': 'registration',
      }; */
      Map<String, dynamic> requestBodyForOTP = {
        'phone': getPhoneFormatted(),
        'email': emailTextEditingController.text,
        'action': 'registration',
      };
      onSuccessSendingOTP(requestBodyForOTP['action']);
    }
  }

/* /* <---- Request for OTP from API ----> */
  Future<void> requestForOTP(Map<String, dynamic> data) async {
    isLoading = true;
    OtpRequestResponse? response = await APIRepo.requestOTP(data);
    isLoading = false;
    if (response == null) {
      APIHelper.onError('No response for requesting otp!');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSendingOTP(response);
  } */

  onSuccessSendingOTP(String requestBodyForOTP) {
    Map<String, dynamic> registrationData = {
      'name': nameTextEditingController.text,
      'phone': getPhoneFormatted(),
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      'role': 'driver',
      'isEmail': isEmail,
      'country': '66c46da00f11b9a5a2165f99',
      'gender': selectedGender,
      'isForRegistration': true
    };
    Get.toNamed(AppPageNames.verificationScreen, arguments: registrationData);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      emailOrPhone = params.emailOrPhone;
      isEmail = screenParameter!.isEmail;
      if (screenParameter!.isEmail) {
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode =
            screenParameter!.countryCode ?? CountryCode.fromCountryCode('GB');
      }
    }
    update();
  }

  Future<void> getCountryElementsRide() async {
    CountryListResponse? response = await APIRepo.getCountryList();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(CountryListResponse response) {
    countryList = response.data;
    update();
  }
/* <---- Initial state ----> */

  @override
  void onInit() async {
    _getScreenParameters();

    super.onInit();
  }

  // Add FocusNodes for each text field
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  void setupFocusNodeListeners() {
    List<FocusNode> focusNodes = [
      emailFocusNode,
      phoneFocusNode,
      nameFocusNode,
      passwordFocusNode,
      confirmPasswordFocusNode
    ];

    for (var node in focusNodes) {
      node.addListener(() {
        if (node.hasFocus) {
          signUpFormKey.currentState?.reset();
        }
      });
    }
  }

  @override
  void onClose() {
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    nameFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.onClose();
  }
}
