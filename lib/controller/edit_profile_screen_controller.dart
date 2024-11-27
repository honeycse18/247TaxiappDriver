import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/country_list_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/model/screenParameters/select_screen_parameters.dart';
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

class EditProfileScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  String emailOrPhone = '';
  UserDetailsData userDetails = UserDetailsData.empty();
  UserDetailsCountry? selectedCountry;
  List<UserDetailsCountry> countryList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  String dialCode = '';
  String phoneNumber = '';

  bool editActive = false;

  bool imageEdit = false;
  bool nameEdit = false;
  bool emailEdit = false;
  bool phoneEdit = false;
  bool dialEdit = false;
  bool genderEdit = false;
  bool addressEdit = false;
  bool countryEdit = false;
  bool rateEdit = false;
  bool experienceEdit = false;
  bool aboutEdit = false;
  // Uint8List selectedProfileImages = Uint8List(0);
  Uint8List selectedProfileImage = Uint8List(0);
  String? selectedGender;

  final RxBool isDropdownOpen = false.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  LocationModel? selectedLocation;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController hourlyRateTextEditingController =
      TextEditingController();
  TextEditingController experienceTextEditingController =
      TextEditingController();
  TextEditingController aboutYourselfTextEditingController =
      TextEditingController();

  var selectedBookingDate = DateTime.now().obs;
  var selectedBookingTime = TimeOfDay.now().obs;
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');

  bool isEditing = false; // New state variable to manage edit mode

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  String formatDateTime(DateTime date, TimeOfDay time) {
    DateTime combinedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return Helper.timeZoneSuffixedDateTimeFormat(combinedDateTime);
  }

  onEditImageButtonTap() {
    if (fieldEditCheck()) {
      return;
    }
    Helper.pickImage(
        onSuccessUploadSingleImage: _onSuccessUploadingProfileImage,
        imageName: 'Profile Image');
  }

  void _onSuccessUploadingProfileImage(
      Uint8List? rawImagesData, Map<String, dynamic> additionalData) {
    update();
    if (rawImagesData == null) {
      imageEdit = false;
    } else {
      imageEdit = true;
      selectedProfileImage = rawImagesData;
    }
    update();
    editable();
    Helper.showSnackBar(
      'Profile image uploaded successfully',
    );
  }

  bool fieldEditCheck() {
    bool ret = false;
    if (nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit ||
        rateEdit ||
        experienceEdit ||
        genderEdit ||
        aboutEdit ||
        countryEdit) {
      AppDialogs.showConfirmDialog(
        messageText:
            'You can update either image or fields at once!\nDo you want to clear image?',
        onYesTap: () async {
          nameTextEditingController.text = '';
          emailTextEditingController.text = '';
          phoneTextEditingController.text = '';
          addressTextEditingController.text = '';
          selectedCountry = countryList.firstWhereOrNull(
              (element) => element.id == userDetails.country.id);
          nameEdit = false;
          emailEdit = false;
          phoneEdit = false;
          dialEdit = false;
          genderEdit = false;
          addressEdit = false;
          countryEdit = false;
          ret = false;
          rateEdit = false;
          experienceEdit = false;
          genderEdit = false;
          aboutEdit = false;
          update();
          editable();
        },
      );
      if (nameEdit ||
          emailEdit ||
          phoneEdit ||
          dialEdit ||
          genderEdit ||
          addressEdit ||
          rateEdit ||
          experienceEdit ||
          genderEdit ||
          aboutEdit ||
          countryEdit) {
        ret = true;
      }
    }
    return ret;
  }

  editable() {
    if (imageEdit ||
        nameEdit ||
        emailEdit ||
        phoneEdit ||
        dialEdit ||
        genderEdit ||
        addressEdit ||
        rateEdit ||
        experienceEdit ||
        genderEdit ||
        aboutEdit ||
        genderEdit ||
        countryEdit) {
      editActive = true;
    } else {
      editActive = false;
    }
    update();
  }

  void updateSelectedStartDate(DateTime newDate) {
    selectedBookingDate.value = newDate;
    log(selectedBookingDate.value.toString());
  }

  void updateSelectedStartTime(TimeOfDay newTime) {
    selectedBookingTime.value = newTime;
    log(selectedBookingTime.value.toString());
  }

  void selectGender(String gender) {
    selectedGender = gender;
    genderEdit = true;
    isDropdownOpen.value = false;
    editable(); // Ensure the edit button state is updated
    update();
  }

  void getUser() {
    final phoneNumberParts = Helper.separatePhoneAndDialCode(userDetails.phone);
    dialCode = phoneNumberParts?.dialCode ?? '';
    phoneNumber = phoneNumberParts?.strippedPhoneNumber ?? '';
    LocationModel prevLocation = LocationModel(
        latitude: userDetails.location.lat,
        longitude: userDetails.location.lng,
        address: userDetails.address);
    selectedLocation = prevLocation;
    if (dialCode.isNotEmpty) {
      currentCountryCode = CountryCode.fromDialCode(dialCode);
    }
    selectedCountry = countryList
        .firstWhereOrNull((element) => element.id == userDetails.country.id);

    update();
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) {
    userDetails = response.data;
    selectedGender = userDetails.gender;
    update();
    getUser();
  }

  bool imageEditCheck() {
    bool ret = false;
    if (imageEdit) {
      AppDialogs.showConfirmDialog(
        shouldCloseDialogOnceYesTapped: true,
        messageText: 'Do you want to clear image?',
        onYesTap: () async {
          selectedProfileImage = Uint8List(0);
          imageEdit = false;
          editable();
          ret = false;
          update();
        },
      );
      if (imageEdit) {
        ret = true;
      }
    }
    return ret;
  }

  void onAddressTap() async {
    if (imageEditCheck()) {
      return;
    }
    dynamic result = await Get.toNamed(AppPageNames.selectLocationScreen,
        arguments: SelectLocationScreenParameters(
            screenTitle:
                AppLanguageTranslation.selectAddressTransKey.toCurrentLanguage,
            showCurrentLocationButton: true,
            locationModel: selectedLocation));
    if (result is LocationModel) {
      addressTextEditingController.text = result.address;
      selectedLocation = result;
      update();
    }
  }

  Widget countryElementsList(int index, UserDetailsCountry country) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            country.code,
            height: 60,
            width: 60,
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

  Future<void> getCountryElementsRide() async {
    CountryListResponse? response = await APIRepo.getCountryList();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingElements(response);
  }

  onSuccessRetrievingElements(CountryListResponse response) {
    countryList = response.data;
    update();
  }

  void onSaveChangesButtonTap() async {
    isLoading = true;
    await updateProfile();
    isLoading = false;
    isEditing = false; // Disable edit mode after saving changes
    update();
  }

  Future<void> updateProfile() async {
    final selectedProfileImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedProfileImage);

    final FormData requestBody = FormData({});
    final Map<String, dynamic> requestBodyJson = {};
    RawAPIResponse? response;

    if (imageEdit) {
      requestBody.files.add(MapEntry(
          'image',
          MultipartFile(selectedProfileImageConvertedToByte,
              filename: 'profile_image.jpg', contentType: 'image/jpeg')));
    }
    if (addressEdit) {
      final Map<String, dynamic> location = {
        'lat': selectedLocation?.latitude ?? 0,
        'lng': selectedLocation?.longitude ?? 0
      };
      requestBodyJson['address'] = selectedLocation?.address ?? '';
      requestBodyJson['location'] = location;
    }
    if (nameEdit) {
      requestBodyJson['name'] = nameTextEditingController.text;
    }
    if (countryEdit) {
      requestBodyJson['country'] = selectedCountry?.id ?? '';
    }

    if (experienceEdit) {
      requestBodyJson['experience'] = experienceTextEditingController.text;
    }
    if (aboutEdit) {
      requestBodyJson['about'] = aboutYourselfTextEditingController.text;
    }
    if (genderEdit) {
      requestBodyJson['gender'] = selectedGender;
    }
    String requestBodyString = jsonEncode(requestBodyJson);

    if (imageEdit) {
      isLoading = true;

      response = await APIRepo.updateUserProfile(requestBody);
    } else {
      isLoading = true;

      response = await APIRepo.updateUserProfile(requestBodyString);
    }

    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessUpdatingProfile(response);
  }

  onSuccessUpdatingProfile(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    setUpdatedUserDetailsToLocalStorage();
  }

  Future<void> setUpdatedUserDetailsToLocalStorage() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
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
    getUser();
    selectedProfileImage = Uint8List(0);

    imageEdit = false;
    nameEdit = false;
    emailEdit = false;
    phoneEdit = false;
    dialEdit = false;
    genderEdit = false;
    addressEdit = false;
    countryEdit = false;
    rateEdit = false;
    experienceEdit = false;
    genderEdit = false;
    aboutEdit = false;
    editable();
    update();
    getLoggedInUserDetails();
  }

  void onEditProfileButtonTap() async {
    if (userDetails.rideStatus.id == '') {
      await AppDialogs.showConfirmDialog(
          messageText: 'Are you sure you want to edit profile?',
          onYesTap: () async {
            isEditing = true;
          });
    } else {
      AppDialogs.showErrorDialog(
          messageText:
              'You have an active ride.\n You can not edit profile now');
    }

    update();
  }

  @override
  void onInit() async {
    userDetails = Helper.getUser();
    getLoggedInUserDetails();
    getCountryElementsRide();
    // getUser();
    nameTextEditingController.addListener(() {
      imageEditCheck();
      if (nameTextEditingController.text.isNotEmpty &&
          nameTextEditingController.text != userDetails.name) {
        nameEdit = true;
      } else {
        nameEdit = false;
      }
      update();
      editable();
    });
    addressTextEditingController.addListener(() {
      imageEditCheck();
      if (addressTextEditingController.text.isNotEmpty &&
          addressTextEditingController.text != userDetails.address) {
        addressEdit = true;
      } else {
        addressEdit = false;
      }
      update();
      editable();
    });

    hourlyRateTextEditingController.addListener(() {
      imageEditCheck();
      if (hourlyRateTextEditingController.text.isNotEmpty &&
          hourlyRateTextEditingController.text != userDetails.rate.toString()) {
        rateEdit = true;
      } else {
        rateEdit = false;
      }
      update();
      editable();
    });
    experienceTextEditingController.addListener(() {
      imageEditCheck();
      if (experienceTextEditingController.text.isNotEmpty &&
          experienceTextEditingController.text != userDetails.experience) {
        experienceEdit = true;
      } else {
        experienceEdit = false;
      }
      update();
      editable();
    });
    aboutYourselfTextEditingController.addListener(() {
      imageEditCheck();
      if (aboutYourselfTextEditingController.text.isNotEmpty &&
          aboutYourselfTextEditingController.text != userDetails.about) {
        aboutEdit = true;
      } else {
        aboutEdit = false;
      }
      update();
      editable();
    });

    super.onInit();
  }
}
