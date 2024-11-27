import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxiappdriver/controller/edit_document_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/documents_field_widget.dart';

class EditDocumentScreen extends StatelessWidget {
  const EditDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDocumentScreenController>(
      global: false,
      init: EditDocumentScreenController(),
      builder: (controller) => Scaffold(
        extendBody: false,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText: 'Documents',
            hasBackButton: true),
        body: ScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppGaps.hGap20,
                    MultiMixedImageDataUploadSectionWidget(
                      label: 'Id Card',
                      uploadImageButtonFocusNode:
                          controller.idCardFrontImageUploadButtonFocusNode,
                      isRequired: true,
                      imageDataList: controller.idCardImageDataList,
                      onImageUploadTap: controller.onUploadIdCardImageTap,
                      onImageDeleteTap: controller.onDeleteIDCardImageTap,
                    ),
                    AppGaps.hGap20,
                    AppGaps.hGap20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DocumentsFieldWidget(
                            focusNode:
                                controller.taxiDriverBadgeUploadButtonFocusNode,
                            isGet: (controller
                                    .userDetails.taxiDriverBadge.isNotEmpty ||
                                controller
                                    .selectedDriverBadgeImages.isNotEmpty),
                            onClickTap: () {
                              if (controller
                                  .selectedDriverBadgeImages.isNotEmpty) {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments:
                                        controller.selectedDriverBadgeImages);
                              } else {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments:
                                        controller.userDetails.taxiDriverBadge);
                              }
                            },
                            isFound:
                                controller.selectedDriverBadgeImages.isNotEmpty,
                            isRequired: true,
                            onTap: controller.taxiDriverBadgeImage,
                            title: 'Driver Badge',
                            hintText: 'Capture',
                            hintText1: 'Captured',
                            rightIcon: SvgPicture.asset(
                                AppAssetImages.rightSingleArrowSVGLogoLine),
                          ),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: CustomTextFormField(
                            validator: Helper.numberFormValidator,
                            onTap: () {
                              controller.update();
                            },
                            isRequired: true,
                            hintText: 'Ex.12345',
                            controller: controller.badgeNumberController,
                            labelText: 'Badge Number',
                          ),
                        )
                      ],
                    ),
                    AppGaps.hGap20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DocumentsFieldWidget(
                            focusNode: controller.driverNIUploadButtonFocusNode,
                            isGet: (controller
                                    .userDetails.driverNi.isNotEmpty ||
                                controller.selectedDriverNiImages.isNotEmpty),
                            onClickTap: () {
                              if (controller
                                  .selectedDriverNiImages.isNotEmpty) {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments:
                                        controller.selectedDriverNiImages);
                              } else {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments: controller.userDetails.driverNi);
                              }
                            },
                            isFound:
                                controller.selectedDriverNiImages.isNotEmpty,
                            isRequired: true,
                            onTap: controller.driverNiImage,
                            title: 'Driver Ni Image',
                            hintText: 'Capture',
                            hintText1: 'Captured',
                            rightIcon: SvgPicture.asset(
                                AppAssetImages.rightSingleArrowSVGLogoLine),
                          ),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: CustomTextFormField(
                            validator: Helper.numberFormValidator,
                            onTap: () {
                              controller.update();
                            },
                            isRequired: true,
                            hintText: 'Ex.12345',
                            controller: controller.niNumberController,
                            labelText: 'Ni Number',
                          ),
                        )
                      ],
                    ),
                    AppGaps.hGap20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DocumentsFieldWidget(
                            focusNode:
                                controller.enhancedDBSUploadButtonFocusNode,
                            isGet: (controller
                                    .selectedEnhancedDbsImages.isNotEmpty ||
                                controller.userDetails.enhanceDbs.isNotEmpty),
                            onClickTap: () {
                              if (controller
                                  .selectedEnhancedDbsImages.isNotEmpty) {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments:
                                        controller.selectedEnhancedDbsImages);
                              } else {
                                Get.toNamed(AppPageNames.photoViewScreen,
                                    arguments:
                                        controller.userDetails.enhanceDbs);
                              }
                            },
                            isFound:
                                controller.selectedEnhancedDbsImages.isNotEmpty,
                            isRequired: true,
                            onTap: controller.taxiDriverEnhanced,
                            title: 'Enhance DBS',
                            hintText: 'Capture',
                            hintText1: 'Captured',
                            rightIcon: SvgPicture.asset(
                                AppAssetImages.rightSingleArrowSVGLogoLine),
                          ),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: CustomTextFormField(
                            validator: Helper.numberFormValidator,
                            onTap: () {
                              controller.update();
                            },
                            isRequired: true,
                            hintText: 'Ex.12345',
                            controller: controller.dbsNumberController,
                            labelText: 'DBS Number',
                          ),
                        )
                      ],
                    ),
                    AppGaps.hGap20,
                    MultiMixedImageDataUploadSectionWidget(
                      uploadImageButtonFocusNode:
                          controller.driverLicenseImagesUploadButtonFocusNode,
                      label: 'Driving License Image',
                      isRequired: true,
                      imageDataList: controller.drivingLicenseImageDataList,
                      onImageUploadTap:
                          controller.onUploadDrivingLicenseImageTap,
                      onImageDeleteTap:
                          controller.onDeleteDrivingLicenseImageTap,
                    ),
                    AppGaps.hGap20,
                    CustomTextFormField(
                      labelText: 'Driving License Expire Date',
                      hintText: 'Expire Date',
                      isReadOnly: true,
                      controller: TextEditingController(
                        text: controller.selectedTaxLicenceEndDate ==
                                AppComponents.defaultUnsetDateTime
                            ? 'Expire Date'
                            : '${DateFormat('dd/MM/yyyy').format(controller.selectedTaxLicenceEndDate)}      ',
                      ),
                      onTap: () async {
                        if (Get.context != null) {
                          DateTime? pickedTaxLicenceEndDate =
                              await showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 100),
                          );
                          if (pickedTaxLicenceEndDate != null) {
                            controller.updateSelectedTaxLicenceEndDate(
                                pickedTaxLicenceEndDate);
                          }
                        }
                        controller.update();
                      },
                      isRequired: true,
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                    AppGaps.hGap20,
                    AppGaps.hGap130,
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 30 + context.mediaQueryViewInsets.bottom,
                  right: 20,
                  left: 20),
              child: Obx(() => CustomStretchedTextButtonWidget(
                    isLoading: controller.isLoading,
                    buttonText: "Update Document",
                    onTap: controller.areAllFieldsFilled
                        ? controller.onUpdateDocumentButtonTap
                        : null,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
