import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxiappdriver/model/api_response/car_brand_response.dart';
import 'package:taxiappdriver/model/api_response/car_categories_response.dart';
import 'package:taxiappdriver/model/api_response/car_model_response.dart';
import 'package:taxiappdriver/model/api_response/my_vehicle_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/locals/extract_mixed_image_data.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/screens/zoom_drawer/year_picker.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/color_picker_dialouge.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

import 'package:taxiappdriver/widgets/screen_widget/documents_field_widget.dart';

class AddVehicleScreenController extends GetxController {
  TextEditingController valueController = TextEditingController();
  String carId = '';
  bool shouldPop = false;
  FocusNode vehicleV5FocusNode = FocusNode();
  FocusNode vehicleImagesUploadButtonFocusNode = FocusNode();
/*   bool get shouldPop => _shouldPop;
  set shouldPop(bool value) {
    _shouldPop = value;
    update();
  } */

  bool get shouldDisableNextButton {
    return ((selectedBrand == null ||
            selectedModel == null ||
            selectedModelYear.year <= 2000 ||
            carCategoriesCategory == null ||
            luggageTextEditingController.text.isEmpty ||
            valueController.text.isEmpty ||
            vehicleNumberTextEditingController.text.isEmpty ||
            v5Images.isEmpty ||
            vehicleImagesData.isEmpty) &&
        carId.isEmpty);
  }

  bool get shouldDisableUpdateButton {
    return ((taxFrontImages.isEmpty ||
            taxBackImages.isEmpty ||
            insurancesImages.isEmpty ||
            motImages.isEmpty ||
            vehicleImagesData.isEmpty) &&
        carId.isEmpty);
  }

  bool _isBrandLoading = false;
  bool get isBrandLoading => _isBrandLoading;
  set isBrandLoading(bool value) {
    _isBrandLoading = value;
    update();
  }

  bool _isModelLoading = false;
  bool get isModelLoading => _isModelLoading;
  set isModelLoading(bool value) {
    _isModelLoading = value;
    update();
  }

  bool _isCategoriesLoading = false;
  bool get isCategoriesLoading => _isCategoriesLoading;
  set isCategoriesLoading(bool value) {
    _isCategoriesLoading = value;
    update();
  }

  bool get isEditing => carId.isNotEmpty;

  MyVehicleDetails myVehicleDetails = MyVehicleDetails.empty();

  void updateColor(Color color) {
    selectedColor = color;
    update();
  }

  BrandElement? selectedBrand;
  List<BrandElement> carBrands = [];
  ModelElement? selectedModel;
  List<ModelElement> carModels = [];
  CarCategoriesCategory? carCategoriesCategory;
  List<CarCategoriesCategory> carCategories = [];

  final GlobalKey<FormState> addCarFstFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarSecondFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> addCarThirdFormKey = GlobalKey<FormState>();
  AddVehicleTabState _addVehicleState = AddVehicleTabState.VehicleInfo;

  AddVehicleTabState get addVehicleState => _addVehicleState;

  set addVehicleState(AddVehicleTabState value) {
    _addVehicleState = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  // List<String> galleryImageURLs = [];
  // List<dynamic> selectedVehicleImageURLs = [];
  final List<Object> vehicleImagesData = [];
  List<Uint8List> v5Images = [];
  Uint8List selectedV5Image = Uint8List(0);
  List<Uint8List> taxFrontImages = [];
  Uint8List selectedTaxFrontImage = Uint8List(0);
  List<Uint8List> taxBackImages = [];
  Uint8List selectedTaxBackImage = Uint8List(0);
  List<Uint8List> insurancesImages = [];
  Uint8List selectedInsurancesImage = Uint8List(0);
  List<Uint8List> motImages = [];
  Uint8List selectedMotImage = Uint8List(0);
  DateTime selectedTaxLicenceEndDate = AppComponents.defaultUnsetDateTime;
  DateTime selectedInsuranceEndDate = AppComponents.defaultUnsetDateTime;
  DateTime selectedMotsEndDate = AppComponents.defaultUnsetDateTime;

  //List<CarCategoriesCategory> carCategories = [];

  //CarCategoriesCategory? selectedCategory;
  Color selectedColor = Colors.white;
  String selectedFuelType = 'Diesel';
  String selectedGearType = 'automatic';
  bool hasAC = false;
  var selectedModelYear = DateTime.now();
  final TextEditingController yearController = TextEditingController();

  TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController modelYearTextEditingController =
      TextEditingController();
  TextEditingController maxPowerTextEditingController = TextEditingController();
  TextEditingController maxSpeedTextEditingController = TextEditingController();
  TextEditingController seatCapacityTextEditingController =
      TextEditingController();
  TextEditingController vehicleColorTextEditingController =
      TextEditingController();
  TextEditingController fuelTypeTextEditingController = TextEditingController();
  TextEditingController milageTextEditingController = TextEditingController();
  TextEditingController numberPlateTextEditingController =
      TextEditingController();
  TextEditingController luggageTextEditingController = TextEditingController();
  void updateSelectedEndDate(DateTime endDate) {
    selectedModelYear = endDate;
  }

  void onUploadAddVehicleImageTap() {
    vehicleImagesUploadButtonFocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessOnUploadAddGalleryImageTap,
        imageName: 'Vehicle Image');
  }

  void _onSuccessOnUploadAddGalleryImageTap(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    // selectedVehicleImageURLs .addAll(rawImagesData.map((e) => e as dynamic).toList());
    vehicleImagesData.addAll(rawImagesData);
    update();
    // Get.snackbar(
    //   AppLanguageTranslation.successfullyUploadedTranskey.toCurrentLanguage,
    //   AppLanguageTranslation
    //       .successfullyUploadedNewThumbnailImageTranskey.toCurrentLanguage,
    // );
    Helper.showSnackBar('Image uploaded successfully');
  }

  void onUploadDeleteVehicleImageTap(int index) {
    try {
      // selectedVehicleImageURLs.removeAt(index);
      vehicleImagesData.removeAt(index);
      update();
      /* Get.snackbar(
          AppLanguageTranslation.successfullyRemovedTranskey.toCurrentLanguage,
          AppLanguageTranslation
              .successfullyRemovedThumbnailImageTranskey.toCurrentLanguage,
          backgroundColor: AppColors.successColor); */
      Helper.showSnackBar('Image removed successfully');
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somthingWentWrongWithRemovingExistingImageTranskey
              .toCurrentLanguage);
      return;
    }
  }

  void onDeleteUploadedVehicleImageTap(int index) {
    try {
      vehicleImagesUploadButtonFocusNode.requestFocus();

      // galleryImageURLs.removeAt(index);
      vehicleImagesData.removeAt(index);
      update();
      // Get.snackbar(
      //     AppLanguageTranslation.successfullyRemovedTranskey.toCurrentLanguage,
      //     AppLanguageTranslation
      //         .successfullyRemovedThumbnailImageTranskey.toCurrentLanguage,
      //     backgroundColor: AppColors.successColor);
      Helper.showSnackBar('Image removed successfully');
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somthingWentWrongWithRemovingExistingImageTranskey
              .toCurrentLanguage);
      return;
    }
  }

  Future<void> onWillPopScope(bool canPop) async {
    /* if (canPop) {
      if (vehicleNumberTextEditingController.text.isNotEmpty ||
          vehicleModelTextEditingController.text.isNotEmpty ||
          modelYearTextEditingController.text.isNotEmpty ||
          maxPowerTextEditingController.text.isNotEmpty ||
          maxSpeedTextEditingController.text.isNotEmpty ||
          seatCapacityTextEditingController.text.isNotEmpty ||
          vehicleColorTextEditingController.text.isNotEmpty ||
          fuelTypeTextEditingController.text.isNotEmpty ||
          milageTextEditingController.text.isNotEmpty ||
          numberPlateTextEditingController.text.isNotEmpty) {
        AppDialogs.showConfirmDialog(
            messageText: 'Do you want to exit',
            onYesTap: () async {
              Get.back();
            });
      } else {
        Get.back();
      }
    } */ /* else {
      Get.back();
    } */
    if (canPop) {
      return;
    }
    final isEditing = (vehicleNumberTextEditingController.text.isNotEmpty ||
        vehicleModelTextEditingController.text.isNotEmpty ||
        modelYearTextEditingController.text.isNotEmpty ||
        maxPowerTextEditingController.text.isNotEmpty ||
        maxSpeedTextEditingController.text.isNotEmpty ||
        seatCapacityTextEditingController.text.isNotEmpty ||
        vehicleColorTextEditingController.text.isNotEmpty ||
        fuelTypeTextEditingController.text.isNotEmpty ||
        milageTextEditingController.text.isNotEmpty ||
        numberPlateTextEditingController.text.isNotEmpty);
    if (isEditing) {
      shouldPop = false;
      AppDialogs.showConfirmDialog(
          messageText: 'Do you want to exit',
          shouldCloseDialogOnceYesTapped: false,
          onYesTap: () async {
            shouldPop = true;
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.back();
          });
    } else {
      shouldPop = true;
      Get.back();
    }
  }

  final RxBool isSubmitAddVehicleLoading = false.obs;
  final RxBool isAddVehicleDetailsLoading = false.obs;

  List<Widget> currentOrderDetailsTabContentWidgets(
      AddVehicleTabState addVehicleTabState) {
    switch (addVehicleTabState) {
      case AddVehicleTabState.VehicleInfo:
        return step1TabContentWidgets();
      case AddVehicleTabState.VehicleDocuments:
        return step2TabContentWidgets();

      default:
        return step1TabContentWidgets();
    }
  }

  List<Widget> step1TabContentWidgets() {
    return [
      Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormFieldWidget(
              isLoading: isBrandLoading,
              isRequired: true,
              hintText: '-Select-',
              value: selectedBrand,
              labelText: 'Vehicle Brand',
              items: carBrands,
              getItemTextIndex: (i, p0) => p0.name,
              onChanged: (selectedItem) {
                onBrandChanged(selectedItem);
              },
            ),
            AppGaps.hGap24,
            DropdownButtonFormFieldWidget(
              isLoading: isModelLoading,
              isRequired: true,
              hintText: '-Select-',
              value: selectedModel,
              labelText: 'Vehicle Model',
              items: carModels,
              getItemTextIndex: (i, p0) => p0.name,
              onChanged: (selectedItem) {
                onModelChanged(selectedItem);
              },
            ),
            AppGaps.hGap24,
            CustomTextFormField(
              isRequired: true,
              labelText: 'Model Year',
              hintText: '-Select-',
              isReadOnly: true,
              controller: TextEditingController(
                text: DateFormat('yyyy').format(selectedModelYear),
              ),
              prefixIcon: Icon(Icons.calendar_month),
              onTap: () async {
                final result = await Get.dialog(YearPickerScreen());
                if (result is DateTime) {
                  onModelYearChanged(result);
                }
              },
            ),
            AppGaps.hGap24,
            DropdownButtonFormFieldWidget(
              isLoading: isCategoriesLoading,
              isRequired: true,
              hintText: '-Select-',
              value: carCategoriesCategory,
              labelText: 'Select Categories',
              items: carCategories,
              getItemTextIndex: (i, p0) => p0.name,
              onChanged: (selectedItem) {
                onCategoryChanged(selectedItem);
              },
            ),
            AppGaps.hGap24,
            CustomTextFormField(
              controller: luggageTextEditingController,
              isRequired: true,
              textInputType: TextInputType.number,
              hintText: 'Ex: 5',
              labelText: 'Luggage Space',
              prefixIcon: Icon(Icons.luggage_outlined),
            ),
            AppGaps.hGap24,
            CustomTextFormField(
              controller: valueController,
              isRequired: true,
              isReadOnly: true,
              textInputType: TextInputType.number,
              hintText: 'Select Color',
              labelText: 'Select Color',
              prefixIcon: Icon(Icons.color_lens_outlined),
              suffixIcon: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: selectedColor,
                ),
              ),
              onTap: () async {
                final result = await Get.dialog(ColorPickerDialog());

                if (result is Color) {
                  onSelectedColor(result);
                }
              },
            ),
            AppGaps.hGap24,
            CustomTextFormField(
              //  labelTextColor: AppColors.mainTextColor,
              controller: vehicleNumberTextEditingController,
              labelText: 'Vehicle Registration Number',
              hintText: 'Ex. 54446444',
            ),
            AppGaps.hGap24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vehicle V5',
                  style: AppTextStyles.labelTextStyle,
                ),
                AppGaps.hGap10,
                RawButtonWidget(
                  onTap: pickV5Image,
                  focusNode: vehicleV5FocusNode,
                  child: Container(
                    height: 56,
                    color: AppColors.fieldbodyColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/capture.png'),
                              AppGaps.wGap10,
                              const Text(
                                'Select image',
                              ),
                            ],
                          ),
                          const SvgPictureAssetWidget(
                            AppAssetImages.rightSingleArrowSVGLogoLine,
                            color: AppColors.curveColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppGaps.hGap8,
                Row(
                  children: [
                    if (myVehicleDetails.vehicleV5.isNotEmpty ||
                        v5Images.isNotEmpty)
                      RawButtonWidget(
                        onTap: () {
                          if (v5Images.isNotEmpty) {
                            Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: v5Images.first);
                          } else {
                            Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: myVehicleDetails.vehicleV5);
                          }
                        },
                        child: const Text(
                          'Click Here to view',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            AppGaps.hGap24,
            /* selectedVehicleImageURLs.isEmpty
                ? /* MultiImageUploadSectionWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                    onImageDeleteTap: onUploadDeleteVehicleImageTap,
                  )
                : SelectedLocalImageWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                    imagesBytes: selectedVehicleImageURLs,
                    onImageDeleteTap: onUploadDeleteVehicleImageTap,
                  ), */ */
/*             selectedVehicleImageURLs.isEmpty
                ? MultiImageUploadSectionWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                    onImageDeleteTap: onDeleteUploadedVehicleImageTap,
                  )
                : SelectedLocalImageWidget(
                    label: AppLanguageTranslation
                        .vehicleImageTransKey.toCurrentLanguage,
                    isRequired: true,
                    imageURLs: galleryImageURLs,
                    onImageUploadTap: onUploadAddVehicleImageTap,
                    imagesBytes: selectedVehicleImageURLs,
                    onImageDeleteTap: onUploadDeleteVehicleImageTap,
                  ), */
            MultiMixedImageDataUploadSectionWidget(
              uploadImageButtonFocusNode: vehicleImagesUploadButtonFocusNode,
              label:
                  AppLanguageTranslation.vehicleImageTransKey.toCurrentLanguage,
              isRequired: true,
              imageDataList: vehicleImagesData,
              onImageUploadTap: onUploadAddVehicleImageTap,
              onImageDeleteTap: onDeleteUploadedVehicleImageTap,
            ),
            AppGaps.hGap10,
          ])
    ];
  }

  List<Widget> step2TabContentWidgets() {
    return [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppGaps.hGap24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DocumentsFieldWidget(
                    onClickTap: () {
                      if (taxFrontImages.isNotEmpty) {
                        Get.toNamed(AppPageNames.photoViewScreen,
                            arguments: taxFrontImages.first);
                      } else {
                        Get.toNamed(AppPageNames.photoViewScreen,
                            arguments: myVehicleDetails.licenseImageFront);
                      }
                    },
                    isFound: taxFrontImages.isNotEmpty,
                    isGet: (myVehicleDetails.licenseImageFront.isNotEmpty ||
                        taxFrontImages.isNotEmpty),
                    isRequired: true,
                    onTap: pickTaxFrontImage,
                    title: 'Licensed Image',
                    hintText: 'Front',
                    hintText1: 'Front',
                    rightIcon: SvgPicture.asset(
                        AppAssetImages.rightSingleArrowSVGLogoLine),
                  ),
                ],
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DocumentsFieldWidget(
                    onClickTap: () {
                      if (taxBackImages.isNotEmpty) {
                        Get.toNamed(AppPageNames.photoViewScreen,
                            arguments: taxBackImages.first);
                      } else {
                        Get.toNamed(AppPageNames.photoViewScreen,
                            arguments: myVehicleDetails.licenseImageBack);
                      }
                    },
                    isRequired: true,
                    isFound: taxBackImages.isNotEmpty,
                    isGet: (myVehicleDetails.licenseImageBack.isNotEmpty ||
                        taxBackImages.isNotEmpty),
                    onTap: pickTaxBackImage,
                    title: '',
                    hintText: 'Back',
                    hintText1: 'Back',
                    rightIcon: SvgPicture.asset(
                        AppAssetImages.rightSingleArrowSVGLogoLine),
                  ),
                ],
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        CustomTextFormField(
          isReadOnly: true,
          controller: TextEditingController(
            text: selectedTaxLicenceEndDate ==
                    AppComponents.defaultUnsetDateTime
                ? 'Enter Expire Date'
                : '${DateFormat('dd/MM/yyyy').format(selectedTaxLicenceEndDate)}      ',
          ),
          onTap: () async {
            if (Get.context != null) {
              DateTime? pickedTaxLicenceEndDate = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 100),
              );
              if (pickedTaxLicenceEndDate != null) {
                updateSelectedTaxLicenceEndDate(pickedTaxLicenceEndDate);
              }
            }
            update();
          },
          isRequired: true,
          labelText: 'License Expire Date',
          hintText: 'Expire Date',
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
          ),
        ),
        AppGaps.hGap24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DocumentsFieldWidget(
                onClickTap: () {
                  if (insurancesImages.isNotEmpty) {
                    Get.toNamed(AppPageNames.photoViewScreen,
                        arguments: insurancesImages.first);
                  } else {
                    Get.toNamed(AppPageNames.photoViewScreen,
                        arguments: myVehicleDetails.insuranceCertificate);
                  }
                },
                isFound: insurancesImages.isNotEmpty,
                isRequired: true,
                isGet: (myVehicleDetails.insuranceCertificate.isNotEmpty ||
                    insurancesImages.isNotEmpty),
                onTap: pickInsurancesImage,
                title: 'Insurance Certificate',
                hintText: 'Capture',
                hintText1: 'Captured',
                rightIcon: SvgPicture.asset(
                    AppAssetImages.rightSingleArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                isReadOnly: true,
                controller: TextEditingController(
                  text: selectedInsuranceEndDate ==
                          AppComponents.defaultUnsetDateTime
                      ? 'Expire Date'
                      : '${DateFormat('dd/MM/yyyy').format(selectedInsuranceEndDate)}      ' /* '${DateFormat('dd/MM/yyyy').format(selectedInsuranceEndDate.value)}      ' */,
                ),
                onTap: () async {
                  if (Get.context != null) {
                    DateTime? pickedInsuranceEndDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 100),
                    );
                    if (pickedInsuranceEndDate != null) {
                      updateSelectedInsuranceEndDate(pickedInsuranceEndDate);
                    }
                  }
                  update();
                },
                isRequired: true,
                labelText: 'Expire Date',
                hintText: 'Expire Date',
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                ),
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DocumentsFieldWidget(
                onClickTap: () {
                  if (motImages.isNotEmpty) {
                    Get.toNamed(AppPageNames.photoViewScreen,
                        arguments: motImages.first);
                  } else {
                    Get.toNamed(AppPageNames.photoViewScreen,
                        arguments: myVehicleDetails.insuranceCertificate);
                  }
                },
                isGet: (myVehicleDetails.insuranceCertificate.isNotEmpty ||
                    motImages.isNotEmpty),
                isRequired: true,
                isFound: motImages.isNotEmpty,
                onTap: pickMotImage,
                title: 'MOTs Certificate',
                hintText: 'Capture',
                hintText1: 'Captured',
                rightIcon: SvgPicture.asset(
                    AppAssetImages.rightSingleArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                isReadOnly: true,
                controller: TextEditingController(
                  text: selectedMotsEndDate ==
                          AppComponents.defaultUnsetDateTime
                      ? 'Expire Date'
                      : '${DateFormat('dd/MM/yyyy').format(selectedMotsEndDate)}      ' /* '${DateFormat('dd/MM/yyyy').format(selectedMotsEndDate)}      ' */,
                ),
                onTap: () async {
                  if (Get.context != null) {
                    DateTime? pickedMotsEndDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 100),
                    );
                    if (pickedMotsEndDate != null) {
                      updateSelectedMotsEndDate(pickedMotsEndDate);
                    }
                  }
                  update();
                },
                isRequired: true,
                labelText: 'Expire Date',
                hintText: 'Expire Date',
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                ),
              ),
            ),
          ],
        ),
        AppGaps.hGap10,
      ])
    ];
  }

  Future<void> addVehicle() async {
    isLoading = true;

    final selectedVehicleV5ImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedV5Image);
    final selectedTaxFrontImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedTaxFrontImage);
    final selectedTaxBackImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedTaxBackImage);
    final selectedInsurancesImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedInsurancesImage);
    final selectedMotsImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedMotImage);

    final FormData requestBody = FormData({});
    RawAPIResponse? response;

    requestBody.files.add(MapEntry(
        'vehicle_v5',
        MultipartFile(selectedVehicleV5ImageConvertedToByte,
            filename: 'vehicle_v5.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'license_image_front',
        MultipartFile(selectedTaxFrontImageConvertedToByte,
            filename: 'license_image_front.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'license_image_back',
        MultipartFile(selectedTaxBackImageConvertedToByte,
            filename: 'license_image_back.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'insurance_certificate',
        MultipartFile(selectedInsurancesImageConvertedToByte,
            filename: 'insurance_certificate.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'mot_certificate',
        MultipartFile(selectedMotsImageConvertedToByte,
            filename: 'mot_certificate.jpg', contentType: 'image/jpeg')));
    requestBody.fields.add(MapEntry('brand', selectedBrand?.id ?? ''));
    requestBody.fields.add(MapEntry('brand_model', selectedModel?.id ?? ''));
    requestBody.fields.add(MapEntry('year', selectedModelYear.toString()));
    requestBody.fields
        .add(MapEntry('category', carCategoriesCategory?.id ?? ''));
    requestBody.fields.add(MapEntry(
        'color',
        Helper.getTextHexColorCodeFromColor(selectedColor,
            shouldInsertHashCharacter: true)));
    requestBody.fields.add(
        MapEntry('vehicle_number', vehicleNumberTextEditingController.text));
    requestBody.fields
        .add(MapEntry('luggage_space', luggageTextEditingController.text));
    requestBody.fields
        .add(MapEntry('license_expiry', selectedTaxLicenceEndDate.toString()));
    requestBody.fields
        .add(MapEntry('insurance_expiry', selectedInsuranceEndDate.toString()));
    requestBody.fields
        .add(MapEntry('mot_expiry', selectedMotsEndDate.toString()));
    final extractedImageData = ExtractedMixedImageData.from(vehicleImagesData);
    final vehicleImagesAsLocal = extractedImageData.imageMemoryDataList;
    // for (int i = 0; i < selectedVehicleImageURLs.length; i++) {
    for (int i = 0; i < vehicleImagesAsLocal.length; i++) {
      requestBody.files.add(MapEntry(
          'images',
          // MultipartFile(selectedVehicleImageURLs[i],
          MultipartFile(vehicleImagesAsLocal[i],
              filename: 'image_$i.jpg', contentType: 'image/jpeg')));
    }
    if (carId.isEmpty) {
      response = await APIRepo.addVehicle(requestBody);
      isLoading = false;
    }
    try {
      // await Future.wait(selectedVehicleImageURLs.map((e) async {
/*       await Future.wait(vehicleImagesAsLocal.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList()); */
    } catch (e) {}
    // response = await APIRepo.addVehicle(requestBody);
    if (response == null) {
      isLoading = false;

      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      isLoading = false;

      APIHelper.onFailure(response.msg);

      return;
    }
    log(response.toJson().toString());
    onSuccessAddingVehicle(response);
  }

  Future<void> updateVehicle() async {
    isLoading = true;

    final selectedVehicleV5ImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedV5Image);
    final selectedTaxFrontImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedTaxFrontImage);
    final selectedTaxBackImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedTaxBackImage);
    final selectedInsurancesImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedInsurancesImage);
    final selectedMotsImageConvertedToByte =
        await Helper.getTempFileFromImageBytes(selectedMotImage);

    final FormData requestBody = FormData({});
    RawAPIResponse? response;

    requestBody.files.add(MapEntry(
        'vehicle_v5',
        MultipartFile(selectedVehicleV5ImageConvertedToByte,
            filename: 'vehicle_v5.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'license_image_front',
        MultipartFile(selectedTaxFrontImageConvertedToByte,
            filename: 'license_image_front.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'license_image_back',
        MultipartFile(selectedTaxBackImageConvertedToByte,
            filename: 'license_image_back.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'insurance_certificate',
        MultipartFile(selectedInsurancesImageConvertedToByte,
            filename: 'insurance_certificate.jpg', contentType: 'image/jpeg')));
    requestBody.files.add(MapEntry(
        'mot_certificate',
        MultipartFile(selectedMotsImageConvertedToByte,
            filename: 'mot_certificate.jpg', contentType: 'image/jpeg')));
    requestBody.fields.add(MapEntry('brand', selectedBrand?.id ?? ''));
    requestBody.fields.add(MapEntry('brand_model', selectedModel?.id ?? ''));
    requestBody.fields.add(MapEntry('year', selectedModelYear.toString()));
    requestBody.fields
        .add(MapEntry('category', carCategoriesCategory?.id ?? ''));
    requestBody.fields.add(MapEntry(
        'color',
        Helper.getTextHexColorCodeFromColor(selectedColor,
            shouldInsertHashCharacter: true)));
    requestBody.fields.add(
        MapEntry('vehicle_number', vehicleNumberTextEditingController.text));
    requestBody.fields
        .add(MapEntry('luggage_space', luggageTextEditingController.text));
    requestBody.fields
        .add(MapEntry('license_expiry', selectedTaxLicenceEndDate.toString()));
    requestBody.fields
        .add(MapEntry('insurance_expiry', selectedInsuranceEndDate.toString()));
    requestBody.fields
        .add(MapEntry('mot_expiry', selectedMotsEndDate.toString()));
    final extractedImageData = ExtractedMixedImageData.from(vehicleImagesData);
    final vehicleImagesAsURLs = extractedImageData.imageURLs;
    final vehicleImagesAsLocal = extractedImageData.imageMemoryDataList;
    // for (int i = 0; i < selectedVehicleImageURLs.length; i++) {
    for (int i = 0; i < vehicleImagesAsLocal.length; i++) {
      requestBody.files.add(MapEntry(
          'images',
          // MultipartFile(selectedVehicleImageURLs[i],
          MultipartFile(vehicleImagesAsLocal[i],
              filename: 'image_$i.jpg', contentType: 'image/jpeg')));
    }
    requestBody.fields.add(MapEntry('_id', carId));
    /* for (var element in selectedGalleryImageLinks) {
        requestBody.fields.addAll([MapEntry('prev_images', element)]);
      } */
    requestBody.fields
        // .addAll(galleryImageURLs.map((e) => MapEntry('prev_images', e)));
        .addAll(vehicleImagesAsURLs.map((e) => MapEntry('prev_images', e)));

    // requestBody.fields
    //     .add(MapEntry('prev_images', selectedGalleryImageLinks));
    response = await APIRepo.updateVehicleDetails(requestBody);
    isLoading = false;

    try {
/*       await Future.wait(selectedVehicleImageURLs.map((e) async {
        if (e is File) {
          return await e.delete();
        }
      }).toList()); */
    } catch (e) {}
    // response = await APIRepo.addVehicle(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      isLoading = false;

      APIHelper.onFailure(response.msg);

      return;
    }
    isLoading = false;
    log(response.toJson().toString());
    onSuccessAddingVehicle(response);
  }

  Future<void> onSubmitButtonTap() async {
    if (isEditing) {
      await updateVehicle();
      return;
    }
    await addVehicle();
  }

  onSuccessAddingVehicle(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    isLoading = false;
    Get.back(result: true);
  }

  Widget currentAddVehicleTabBottomButtonWidget(
      AddVehicleTabState addVehicleStateValue) {
    Map<AddVehicleTabState, Widget> addVehicleStateWidgetMap = {
      AddVehicleTabState.VehicleInfo: isSubmitAddVehicleLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.nextTransKey.toCurrentLanguage,
              onTap: (shouldDisableNextButton)
                  ? null
                  : () async {
                      addVehicleState = AddVehicleTabState.VehicleDocuments;
                    }),
      AddVehicleTabState.VehicleDocuments: isAddVehicleDetailsLoading.value
          ? const EnrollPaymentButtonLoadingWidget()
          : StretchedTextButtonWidget(
              isLoading: isLoading,
              buttonText: carId != '' ? 'Update Vehicle' : 'Submit',
              onTap: shouldDisableUpdateButton
                  ? null
                  : isLoading
                      ? null
                      : () async {
                          await onSubmitButtonTap();
                        } /* (() {
                if (taxFrontImages.isEmpty ||
                    taxBackImages.isEmpty ||
                    insurancesImages.isEmpty ||
                    motImages.isEmpty ||
                    vehicleImagesData.isEmpty) {
                  return null;
                } else {
                  return () async {
                    await onSubmitButtonTap();
                  };
                }
              }()) */
              /* onTap: () async {
                await onSubmitButtonTap();
              } */
              ),
    };
    return addVehicleStateWidgetMap[addVehicleStateValue] ??
        const Text('Empty');
  }

  pickV5Image() {
    vehicleV5FocusNode.requestFocus();
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingV5Image,
        imageName: 'Vehicle V5 Image');
  }

  pickTaxFrontImage() {
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingTaxFrontImage,
        imageName: 'license Front Image');
  }

  pickTaxBackImage() {
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingTaxBackImage,
        imageName: 'license Back Image');
  }

  pickInsurancesImage() {
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingInsurancesImage,
        imageName: 'Insurance Image');
  }

  pickMotImage() {
    Helper.pickImages(
        onSuccessUploadSingleImage: _onSuccessUploadingMotImage,
        imageName: 'Mot Image');
  }

  //===================
  void _onSuccessUploadingV5Image(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    v5Images.clear();
    v5Images.addAll(rawImagesData);
    update();
    if (v5Images.isEmpty) {
    } else {
      selectedV5Image = v5Images.firstOrNull ?? Uint8List(0);
    }
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }

  //===================
  void _onSuccessUploadingTaxFrontImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    taxFrontImages.clear();
    taxFrontImages.addAll(rawImagesData);
    update();
    if (taxFrontImages.isEmpty) {
    } else {
      selectedTaxFrontImage = taxFrontImages.firstOrNull ?? Uint8List(0);
    }
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }

  //===================
  void _onSuccessUploadingTaxBackImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    taxBackImages.clear();
    taxBackImages.addAll(rawImagesData);
    update();
    if (taxBackImages.isEmpty) {
    } else {
      selectedTaxBackImage = taxBackImages.firstOrNull ?? Uint8List(0);
    }
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }

  //===================
  void _onSuccessUploadingInsurancesImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    insurancesImages.clear();
    insurancesImages.addAll(rawImagesData);
    update();
    if (insurancesImages.isEmpty) {
    } else {
      selectedInsurancesImage = insurancesImages.firstOrNull ?? Uint8List(0);
    }
    update();
    /*  Get.snackbar('', 'Image uploaded successfully',
        snackPosition: SnackPosition.TOP); */
    Helper.showSnackBar('Image uploaded successfully');
  }

  //===================
  void _onSuccessUploadingMotImage(
      List<Uint8List> rawImagesData, Map<String, dynamic> additionalData) {
    motImages.clear();
    motImages.addAll(rawImagesData);
    update();
    if (motImages.isEmpty) {
    } else {
      selectedMotImage = motImages.firstOrNull ?? Uint8List(0);
    }
    update();
    // Get.snackbar('', 'Image uploaded successfully',
    //     snackPosition: SnackPosition.TOP);
    Helper.showSnackBar('Image uploaded successfully');
  }
  //===================

  Future<void> getVehicleBrands() async {
    CarBrandResponse? response = await APIRepo.getCarBrands();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(CarBrandResponse response) {
    carBrands = response.data;
    update();
  }

  Future<void> getVehicleModels(String id) async {
    CarBrandModelResponse? response = await APIRepo.getCarModels(id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessModelList(response);
  }

  onSuccessModelList(CarBrandModelResponse response) {
    carModels = response.data;
    update();
  }

  Future<void> getVehicleCategories(String year) async {
    CarCategoriesResponse? response = await APIRepo.getCarCategories(year);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessCategoriesList(response);
  }

  onSuccessCategoriesList(CarCategoriesResponse response) {
    carCategories = response.data;
    update();
  }

  /*<----------- Get vehicle details from API----------->*/
  Future<void> getVehicleDetails(String vehicleId) async {
    MyVehicleDetailsResponse? response =
        await APIRepo.getVehicleDetails(productId: vehicleId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    _onSuccessGetVehicleDetailsResponse(response);
  }

  Future<void> _onSuccessGetVehicleDetailsResponse(
      MyVehicleDetailsResponse response) async {
    myVehicleDetails = response.data;

    // Set vehicle brand
    final foundBrand = carBrands
        .firstWhereOrNull((element) => element.id == myVehicleDetails.brand.id);
    selectedBrand = foundBrand;
    await triggerShortLoading(
        onLoadingStarted: () => isBrandLoading = true,
        onLoadingFinished: () => isBrandLoading = false);
    await onBrandChanged(selectedBrand);

    // Set vehicle model
    final foundModel = carModels.firstWhereOrNull(
        (element) => element.id == myVehicleDetails.brandModel.id);
    selectedModel = foundModel;
    await triggerShortLoading(
        onLoadingStarted: () => isModelLoading = true,
        onLoadingFinished: () => isModelLoading = false);
    onModelChanged(selectedModel);

    // Set categories
/*     final DateTime foundCategoryYear = DateTime(
        int.tryParse(myVehicleDetails.category.modelYear.firstOrNull ?? '') ??
            AppConstants.defaultUnsetDateTimeYear); */
    final DateTime foundCategoryYear = myVehicleDetails.year;
    if (foundCategoryYear.year != AppConstants.defaultUnsetDateTimeYear) {
      // modelYearTextEditingController.text = myVehicleDetails.category.modelYear.firstOrNull ?? '';
      await onModelYearChanged(foundCategoryYear);
    }

    // Set vehicle model
    final foundCategory = carCategories.firstWhereOrNull(
        (element) => element.id == myVehicleDetails.category.id);
    carCategoriesCategory = foundCategory;
    await triggerShortLoading(
        onLoadingStarted: () => isCategoriesLoading = true,
        onLoadingFinished: () => isCategoriesLoading = false);
    onCategoryChanged(carCategoriesCategory);

    // galleryImageURLs = myVehicleDetails.images;
    vehicleImagesData.clear();
    vehicleImagesData.addAll(myVehicleDetails.images);
    selectedTaxLicenceEndDate = myVehicleDetails.licenseExpiry;
    selectedInsuranceEndDate = myVehicleDetails.insuranceExpiry;
    selectedMotsEndDate = myVehicleDetails.motExpiry;
    vehicleNumberTextEditingController.text = myVehicleDetails.vehicleNumber;
    vehicleModelTextEditingController.text = myVehicleDetails.category.name;
    // selectedBrand?.name = myVehicleDetails.brand.name;
    luggageTextEditingController.text =
        myVehicleDetails.luggageSpace.toString();

    final foundColor =
        Helper.getColorFromTextHexColorCode(myVehicleDetails.color);
    if (foundColor != Colors.transparent) {
      selectedColor = foundColor;
      onSelectedColor(selectedColor);
    }
    // selectedBrand?.name = myVehicleDetails.brand.name;
    update();
  }

  void updateSelectedTaxLicenceEndDate(DateTime newDate) {
    selectedTaxLicenceEndDate = newDate;
    update();
  }

  void updateSelectedInsuranceEndDate(DateTime newDate) {
    selectedInsuranceEndDate = newDate;
    update();
  }

  void updateSelectedMotsEndDate(DateTime newDate) {
    selectedMotsEndDate = newDate;
    update();
  }

  void onSelectedColor(Color result) {
    selectedColor = result;
    valueController.text = Helper.getTextHexColorCodeFromColor(selectedColor);
    update();
  }

  void onCategoryChanged(CarCategoriesCategory? selectedItem) {
    carCategoriesCategory = selectedItem;
    update();
  }

  Future<void> onModelYearChanged(DateTime result) async {
    selectedModelYear = result;
    carCategoriesCategory = null;
    update();
    await getVehicleCategories(selectedModelYear.year.toString());
    update();
  }

  Future<void> onBrandChanged(BrandElement? selectedItem) async {
    selectedBrand = selectedItem;
    selectedModel = null;
    update();
    if (selectedItem == null) {
      return;
    }
    await getVehicleModels(selectedBrand!.id);
  }

  void onModelChanged(ModelElement? selectedItem) {
    selectedModel = selectedItem;
    update();
  }

  Future<void> triggerShortLoading({
    Duration duration = const Duration(milliseconds: 300),
    void Function()? onLoadingStarted,
    void Function()? onLoadingFinished,
  }) async {
    onLoadingStarted?.call();
    await Future.delayed(duration);
    onLoadingFinished?.call();
  }

  void getScreenParameters() {
    dynamic param = Get.arguments;
    if (param is String) {
      carId = param;
    }
    update();
  }

  Future<void> onAsyncInit() async {
    await getVehicleBrands();
    if (isEditing) {
      await getVehicleDetails(carId);
    }
  }

  @override
  void onInit() {
    getScreenParameters();
    onAsyncInit();
    super.onInit();
  }

  @override
  void onClose() {
    vehicleNumberTextEditingController.dispose();
    vehicleModelTextEditingController.dispose();
    modelYearTextEditingController.dispose();
    maxPowerTextEditingController.dispose();
    maxSpeedTextEditingController.dispose();
    seatCapacityTextEditingController.dispose();
    vehicleColorTextEditingController.dispose();
    fuelTypeTextEditingController.dispose();
    milageTextEditingController.dispose();
    numberPlateTextEditingController.dispose();
    vehicleV5FocusNode.dispose();
    vehicleImagesUploadButtonFocusNode.dispose();
    super.onClose();
  }
}
