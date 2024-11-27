import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/documents_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentsScreenController>(
      global: false,
      init: DocumentsScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText: 'Documents',
            hasBackButton: true),
        body: SafeArea(
            child: CustomScaffoldBodyWidget(
                child: Form(
          key: controller.documentFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.userDetails.documents.isNotEmpty) AppGaps.hGap24,
                if (controller.userDetails.documents.isNotEmpty)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Driving License',
                          style: AppTextStyles.labelTextStyle),
                    ],
                  ),
                if (controller.userDetails.documents.isNotEmpty) AppGaps.hGap8,
                if (controller.userDetails.documents.isEmpty)
                  const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmptyScreenWidget(
                            localImageAssetURL:
                                AppAssetImages.emptyDocumentIconImage,
                            title: 'No license photo uploaded')
                      ],
                    ),
                  ),
                if (controller.userDetails.documents.isNotEmpty)
                  Row(
                    children: controller.userDetails.documents
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final document = entry.value;
                      return Expanded(
                        child: UploadedLicenseFrontPhotoWithName(
                          frontImage: document,
                          incrementalValue: index + 1, // Start counting from 1
                        ),
                      );
                    }).toList(),
                  ),
                if (controller.userDetails.documents.isNotEmpty) AppGaps.hGap24,

                if (controller.userDetails.documents.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Driving License Expired Date',
                                style: AppTextStyles.labelTextStyle),
                            AppGaps.hGap5,
                            CustomTextFormField(
                              isReadOnly: true,
                              prefixIcon: Icon(Icons.add_card_outlined),
                              hintText: Helper.ddMMMyyyyFormattedDateTime(
                                  controller.userDetails.drivingLicenseExpired),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                if (controller.userDetails.documents.isNotEmpty) AppGaps.hGap24,
                if (controller.userDetails.idCard.isNotEmpty)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Id Card', style: AppTextStyles.labelTextStyle),
                    ],
                  ),
                if (controller.userDetails.idCard.isNotEmpty) AppGaps.hGap8,
                if (controller.userDetails.idCard.isNotEmpty)
                  Row(
                    children: controller.userDetails.idCard
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final document = entry.value;
                      return Expanded(
                        child: UploadedLicenseFrontPhotoWithName(
                          frontImage: document,
                          incrementalValue: index + 1, // Start counting from 1
                        ),
                      );
                    }).toList(),
                  ),
                if (controller.userDetails.taxiDriverBadge.isNotEmpty)
                  AppGaps.hGap24,
                if (controller.userDetails.taxiDriverBadge.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Driver Badge',
                                style: AppTextStyles.labelTextStyle),
                            UploadedLicenseFrontPhotoWithName(
                              frontImage:
                                  controller.userDetails.taxiDriverBadge,
                              incrementalValue: 1, // Start counting from 1
                            )
                          ],
                        ),
                      ),
                      AppGaps.wGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Badge Number',
                                style: AppTextStyles.labelTextStyle),
                            AppGaps.hGap5,
                            CustomTextFormField(
                              isReadOnly: true,
                              prefixIcon: Icon(Icons.badge_outlined),
                              hintText: controller.userDetails.badgeNumber,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                if (controller.userDetails.driverNi.isNotEmpty) AppGaps.hGap24,
                if (controller.userDetails.driverNi.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Driver NI',
                                style: AppTextStyles.labelTextStyle),
                            UploadedLicenseFrontPhotoWithName(
                              frontImage: controller.userDetails.driverNi,
                              incrementalValue: 1, // Start counting from 1
                            )
                          ],
                        ),
                      ),
                      AppGaps.wGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NI Number',
                                style: AppTextStyles.labelTextStyle),
                            AppGaps.hGap5,
                            CustomTextFormField(
                              isReadOnly: true,
                              prefixIcon: Icon(Icons.add_card_sharp),
                              hintText: controller.userDetails.driverNiNumber,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                if (controller.userDetails.enhanceDbs.isNotEmpty)
                  AppGaps.hGap24,
                // if (controller.userDetails.enhanceDbs != '')
                if (controller.userDetails.enhanceDbs.isNotEmpty)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enhance DBS',
                                style: AppTextStyles.labelTextStyle),
                            UploadedLicenseFrontPhotoWithName(
                              frontImage: controller.userDetails.enhanceDbs,
                              incrementalValue: 1, // Start counting from 1
                            )
                          ],
                        ),
                      ),
                      AppGaps.wGap8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DBS Number',
                                style: AppTextStyles.labelTextStyle),
                            AppGaps.hGap5,
                            CustomTextFormField(
                              isReadOnly: true,
                              prefixIcon:
                                  Icon(Icons.confirmation_number_outlined),
                              hintText: controller.userDetails.dbsNumber,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                AppGaps.hGap24,
              ],
            ),
          ),
        ))),
        bottomNavigationBar: CustomScaffoldBodyWidget(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.userDetails.documents.isNotEmpty
                ? CustomStretchedTextButtonWidget(
                    buttonText: 'Edit Documents',
                    onTap: controller.userDetails.status == 'approved'
                        ? () async {
                            await Get.toNamed(
                              AppPageNames.editDocumentsScreen,
                            );
                            controller.getLoggedInUserDetails();
                          }
                        : null,
                  )
                : CustomStretchedTextButtonWidget(
                    buttonText: 'Complete Profile',
                    onTap: () async {
                      await Get.toNamed(
                        AppPageNames.editDocumentsScreen,
                      );
                      controller.getLoggedInUserDetails();
                    },
                  ),
            AppGaps.hGap37,
          ],
        )),
      ),
    );
  }
}

class UploadedLicenseFrontPhotoWithName extends StatelessWidget {
  final String frontImage;
  final int incrementalValue;
  const UploadedLicenseFrontPhotoWithName({
    super.key,
    required this.frontImage,
    required this.incrementalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F7F9),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: CustomRawListTileWidget(
        borderRadiusRadiusValue: const Radius.circular(5),
        onTap: () {
          Get.toNamed(AppPageNames.photoViewScreen, arguments: frontImage);
          // Show image preview
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CachedNetworkImageWidget(
                    imageURL: frontImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap15,
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          incrementalValue == 1 ? 'Front Image' : 'Back Image',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle,
                        ),
                        AppGaps.hGap5,
                        /* Text("200 KB",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryTextColor)),
                        AppGaps.hGap3, */
                        RawButtonWidget(
                          child: const Text('Click to view',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkColor)),
                          onTap: () async {
                            await Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: frontImage);
                          },
                        )
                      ]),
                ),
                AppGaps.wGap12,
                /* TightIconButtonWidget(
                  icon: SvgPicture.asset(AppAssetImages.trashSVGLogoLine),
                  onTap: () {
                    // Delete Button
                  },
                ), */
              ])
            ],
          ),
        ),
      ),
    );
  }
}
/* 
class UploadedLicenseBackPhotoWithName extends StatelessWidget {
  final String backImage;
  const UploadedLicenseBackPhotoWithName({
    super.key,
    required this.backImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: CustomRawListTileWidget(
        borderRadiusRadiusValue: const Radius.circular(18),
        onTap: () {
          Get.toNamed(AppPageNames.photoViewScreen, arguments: backImage);
          // Show image preview
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 60,
                  width: 90,
                  child: CachedNetworkImageWidget(
                    imageURL: backImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                  ),
                ),
                AppGaps.wGap15,
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Back side Image',
                          style: AppTextStyles.bodyLargeTextStyle,
                        ),
                        AppGaps.hGap3,
                        AppGaps.hGap3,
                        AppGaps.hGap5,
                        /* Text("200 KB",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryTextColor)),
                        AppGaps.hGap3, */
                        RawButtonWidget(
                          child: const Text('Click to view',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkColor)),
                          onTap: () {
                            Get.toNamed(AppPageNames.photoViewScreen,
                                arguments: backImage);
                          },
                        )
                      ]),
                ),
                AppGaps.wGap12,
                /* TightIconButtonWidget(
                  icon: SvgPicture.asset(AppAssetImages.trashSVGLogoLine),
                  onTap: () {
                    // Delete Button
                  },
                ), */
              ])
            ],
          ),
        ),
      ),
    );
  }
}
 */
