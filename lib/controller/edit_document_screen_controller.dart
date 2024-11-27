import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/locals/extract_mixed_image_data.dart';
import 'package:taxiappdriver/model/locals/mixed_image_data.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/list.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class EditDocumentScreenController extends GetxController {
  UserDetailsData userDetails = UserDetailsData.empty();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  // List<String> drivingLicenseImageURLs = [];
  final List<Object> drivingLicenseImageDataList = [];
  // List<dynamic> selectedVehicleImageURLs = [];

  // List<dynamic> selectedDrivingLicenseImageURLs = [];
  // final List<Object> selectedDrivingLicenseImageDataList = [];
  // List<String> idCardImageURLs = [];
  final List<Object> idCardImageDataList = [];
  final List<Object> selectedidCardImageURLs = [];
  DateTime selectedTaxLicenceEndDate = AppComponents.defaultUnsetDateTime;
  // List<Uint8List> driverBadgeImages = [];
  // Uint8List selectedDriverBadgeImages = Uint8List(0);
  MixedImageData selectedDriverBadgeImages = MemoryImageData.empty();
  // List<Uint8List> driverNiImages = [];
  // Uint8List selectedDriverNiImages = Uint8List(0);
  MixedImageData selectedDriverNiImages = MemoryImageData.empty();
  // List<Uint8List> enhancedDbsImages = [];
  // Uint8List selectedEnhancedDbsImages = Uint8List(0);
  MixedImageData selectedEnhancedDbsImages = MemoryImageData.empty();

  TextEditingController dbsNumberController = TextEditingController();
  TextEditingController niNumberController = TextEditingController();
  TextEditingController badgeNumberController = TextEditingController();

  String type = '';
  FocusNode driverLicenseImagesUploadButtonFocusNode = FocusNode();
  FocusNode idCardFrontImageUploadButtonFocusNode = FocusNode();
  FocusNode idCardBackImageUploadButtonFocusNode = FocusNode();
  FocusNode taxiDriverBadgeUploadButtonFocusNode = FocusNode();
  FocusNode driverNIUploadButtonFocusNode = FocusNode();
  FocusNode enhancedDBSUploadButtonFocusNode = FocusNode();

  // Reactive property for checking if all fields are filled
  final RxBool _areAllFieldsFilled = false.obs;
  bool get areAllFieldsFilled => _areAllFieldsFilled.value;

  // Update the reactive property whenever any field changes
  void _updateAreAllFieldsFilled() {
    _areAllFieldsFilled.value = (drivingLicenseImageDataList.isNotEmpty &&
        idCardImageDataList.isNotEmpty &&
        selectedTaxLicenceEndDate != AppComponents.defaultUnsetDateTime &&
        selectedDriverBadgeImages != MemoryImageData.empty() &&
        selectedDriverNiImages != MemoryImageData.empty() &&
        selectedEnhancedDbsImages != MemoryImageData.empty() &&
        badgeNumberController.text.isNotEmpty &&
        niNumberController.text.isNotEmpty &&
        dbsNumberController.text.isNotEmpty);
  }

  //============Taxi Driver badge Image Upload==============

  taxiDriverBadgeImage() {
    taxiDriverBadgeUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingMotImage,
        imageName: 'Driver Badge Image');
  }

  void _onSuccessUploadingMotImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    // driverBadgeImages.clear();
    // driverBadgeImages.addAll(rawImagesData);
    update();
    // if (driverBadgeImages.isEmpty) {
    if (rawImagesData.isEmpty) {
    } else {
      // selectedDriverBadgeImages = driverBadgeImages.firstOrNull ?? Uint8List(0);
      selectedDriverBadgeImages = MemoryImageData(
          memoryData: rawImagesData.firstOrNull ?? MemoryImageData.emptyData);
    }
    _updateAreAllFieldsFilled();
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }

/*   void onUploadDeleteVehicleImageTap(int index) {
    try {
      selectedVehicleImageURLs.removeAt(index);
      update();
      Helper.showSnackBar('Successfully removed driving license image');
    } catch (e) {
      APIHelper.onError('Something went wrong with removing existing image!');
      return;
    }
  } */
  void onDeleteDrivingLicenseImageTap(int index) {
    try {
      driverLicenseImagesUploadButtonFocusNode.requestFocus();

      drivingLicenseImageDataList.removeAt(index);
      _updateAreAllFieldsFilled();
      update();
      Helper.showSnackBar('Successfully removed driving license image');
    } catch (e) {
      APIHelper.onError('Something went wrong with removing existing image!');
      return;
    }
  }

  void onDeleteIDCardImageTap(int index) {
    try {
      idCardFrontImageUploadButtonFocusNode.requestFocus();
      idCardImageDataList.removeAt(index);
      _updateAreAllFieldsFilled();
      update();
      Helper.showSnackBar('Successfully removed ID card image');
    } catch (e) {
      APIHelper.onError('Something went wrong with removing existing image!');
      return;
    }
  }
  //============Enhanced Taxi Driver badge Image Upload==============

  taxiDriverEnhanced() {
    enhancedDBSUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingDbsImage,
        imageName: 'Driver Badge Image');
  }

  void _onSuccessUploadingDbsImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    // enhancedDbsImages.clear();
    // enhancedDbsImages.addAll(rawImagesData);
    update();
    // if (enhancedDbsImages.isEmpty) {
    if (rawImagesData.isEmpty) {
    } else {
      // selectedEnhancedDbsImages = enhancedDbsImages.firstOrNull ?? Uint8List(0);
      selectedEnhancedDbsImages = MemoryImageData(
          memoryData: rawImagesData.firstOrNull ?? MemoryImageData.emptyData);
    }
    _updateAreAllFieldsFilled();
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }
  //============Driver Ni Image Upload==============

  driverNiImage() {
    driverNIUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingNiImage,
        imageName: 'Driver Ni Image');
  }

  void _onSuccessUploadingNiImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    // driverNiImages.clear();
    // driverNiImages.addAll(rawImagesData);
    update();
    // if (driverNiImages.isEmpty) {
    if (rawImagesData.isEmpty) {
    } else {
      // selectedDriverNiImages = driverNiImages.firstOrNull ?? Uint8List(0);
      selectedDriverNiImages = MemoryImageData(
          memoryData: rawImagesData.firstOrNull ?? MemoryImageData.emptyData);
    }
    _updateAreAllFieldsFilled();
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }

  //============Driving License Image Upload==============

/*   void onUploadDrivingLicenseImageTap() {
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessOnUploadAddDrivingLicenseImageTap,
        imageName: 'Vehicle Image');
  } */
  void onUploadDrivingLicenseImageTap() {
    if (drivingLicenseImageDataList.length >= 2) {
      Get.snackbar('Error', 'You can only upload up to 2 images.');
      return;
    }
    driverLicenseImagesUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessOnUploadAddDrivingLicenseImageTap,
        imageName: 'Driving License Image');
  }

  void _onSuccessOnUploadAddDrivingLicenseImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    if (drivingLicenseImageDataList.length + rawImagesData.length > 2) {
      Get.snackbar('Error', 'You can only upload up to 2 images.');
      return;
    }
    drivingLicenseImageDataList.addAll(rawImagesData);
    _updateAreAllFieldsFilled();
    update();
    /*  Get.snackbar(
      AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
      AppLanguageTranslation
          .successfullyUploadedNewThumbnailImageTranskey.toCurrentLanguage,
    ); */
    Helper.showSnackBar('Image uploaded successfully');
  }

  //============Id Card Image Upload==============
  void onUploadIdCardImageTap() {
    if (idCardImageDataList.length >= 2) {
      Get.snackbar('', 'You can only upload up to 2 images.');
      return;
    }
    idCardFrontImageUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessOnUploadAddIdCardImageTap,
        imageName: 'Id Card Image');
  }

  void _onSuccessOnUploadAddIdCardImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    if (idCardImageDataList.length + rawImagesData.length > 2) {
      Get.snackbar('', 'You can only upload up to 2 images.');
      return;
    }
    idCardImageDataList.addAll(rawImagesData);
    _updateAreAllFieldsFilled();
    update();
    /*   Get.snackbar(
      AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
      AppLanguageTranslation
          .successfullyUploadedNewThumbnailImageTranskey.toCurrentLanguage,
    ); */
    Helper.showSnackBar('Image uploaded successfully');
    update();
  }

  void updateSelectedTaxLicenceEndDate(DateTime newDate) {
    selectedTaxLicenceEndDate = newDate;
    _updateAreAllFieldsFilled();
    update();
  }

  Future<void> updateDocument() async {
    final FormData requestBody = FormData({});
    // final Map<String, dynamic> requestBodyJson = {};
    final extractedDrivingLicenseImages =
        ExtractedMixedImageData.from(drivingLicenseImageDataList);
    for (final (i, previousImageURL)
        in extractedDrivingLicenseImages.imageURLs.indexed) {
      requestBody.fields
          .add(MapEntry('prev_driving_license', previousImageURL));
    }
    for (final (i, imageData)
        in extractedDrivingLicenseImages.imageMemoryDataList.indexed) {
      requestBody.files.add(MapEntry(
          'driving_license',
          MultipartFile(imageData,
              filename: 'driving_license_image_$i.jpg',
              contentType: 'image/jpeg')));
    }
    final extractedIDCardImages =
        ExtractedMixedImageData.from(idCardImageDataList);
    for (final (i, previousImageURL)
        in extractedIDCardImages.imageURLs.indexed) {
      requestBody.fields.add(MapEntry('prev_id_card', previousImageURL));
    }
    for (final (i, imageData)
        in extractedIDCardImages.imageMemoryDataList.indexed) {
      requestBody.files.add(MapEntry(
          'id_card',
          MultipartFile(imageData,
              filename: 'id_card_image_$i.jpg', contentType: 'image/jpeg')));
    }
    requestBody.fields
        .add(MapEntry('badge_number', badgeNumberController.text));
    requestBody.fields
        .add(MapEntry('driver_ni_number', niNumberController.text));
    requestBody.fields.add(MapEntry(
        'driving_license_expired',
        APIHelper.toServerDateTimeFormattedStringFromDateTime(
            selectedTaxLicenceEndDate)));
    requestBody.fields.add(MapEntry('dbs_number', dbsNumberController.text));
    if (selectedDriverBadgeImages is MemoryImageData) {
      requestBody.files.add(MapEntry(
          'taxi_driver_badge',
          MultipartFile(
              (selectedDriverBadgeImages as MemoryImageData).memoryData,
              filename: 'taxi_driver_badge.jpg',
              contentType: 'image/jpeg')));
    } else if (selectedDriverBadgeImages is URLImageData) {
      requestBody.fields.add(MapEntry('prev_taxi_driver_badge',
          (selectedDriverBadgeImages as URLImageData).url));
    }
    if (selectedDriverNiImages is MemoryImageData) {
      requestBody.files.add(MapEntry(
          'driver_ni',
          MultipartFile((selectedDriverNiImages as MemoryImageData).memoryData,
              filename: 'driver_ni.jpg', contentType: 'image/jpeg')));
    } else if (selectedDriverNiImages is URLImageData) {
      requestBody.fields.add(MapEntry(
          'prev_driver_ni', (selectedDriverNiImages as URLImageData).url));
    }
    if (selectedEnhancedDbsImages is MemoryImageData) {
      requestBody.files.add(MapEntry(
          'enhance_dbs',
          MultipartFile(
              (selectedEnhancedDbsImages as MemoryImageData).memoryData,
              filename: 'enhance_dbs.jpg',
              contentType: 'image/jpeg')));
    } else if (selectedEnhancedDbsImages is URLImageData) {
      requestBody.fields.add(MapEntry(
          'prev_enhance_dbs', (selectedEnhancedDbsImages as URLImageData).url));
    }
    // String requestBodyString = jsonEncode(requestBodyJson);
    isLoading = true;
    final response = await APIRepo.updateUserProfile(requestBody);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessUpdateDocument(response);
  }

  void onSuccessUpdateDocument(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back(result: true);
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
    drivingLicenseImageDataList.clear();
    drivingLicenseImageDataList.addAll(userDetails.drivingLicense);
    updateSelectedTaxLicenceEndDate(userDetails.drivingLicenseExpired);
    // idCardImageDataList.clear();
    // idCardImageDataList.addAll(userDetails.idCard);
    idCardImageDataList.replaceAllItems(userDetails.idCard);
    badgeNumberController.text = userDetails.badgeNumber;
    niNumberController.text = userDetails.driverNiNumber;
    dbsNumberController.text = userDetails.dbsNumber;
    selectedDriverBadgeImages = URLImageData(url: userDetails.taxiDriverBadge);
    selectedDriverNiImages = URLImageData(url: userDetails.driverNi);
    selectedEnhancedDbsImages = URLImageData(url: userDetails.enhanceDbs);
    _updateAreAllFieldsFilled();
    update();
  }

  void onUpdateDocumentButtonTap() {
    updateDocument();
  }

  Future<void> onAsyncInit() async {
    await getLoggedInUserDetails();
  }

  @override
  void onInit() {
    onAsyncInit();
    super.onInit();
    // Initialize the reactive property
    _updateAreAllFieldsFilled();
  }

  @override
  void onClose() {
    driverLicenseImagesUploadButtonFocusNode.dispose();
    idCardFrontImageUploadButtonFocusNode.dispose();
    idCardBackImageUploadButtonFocusNode.dispose();
    taxiDriverBadgeUploadButtonFocusNode.dispose();
    driverNIUploadButtonFocusNode.dispose();
    enhancedDBSUploadButtonFocusNode.dispose();
    super.onClose();
  }
}
