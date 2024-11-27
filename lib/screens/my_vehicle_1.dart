import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taxiappdriver/controller/my_vehicle_1_controller.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/vehicle_list_tab_screen_widget.dart';
import 'package:taxiappdriver/widgets/vehicle_features_item_widget.dart';

//Vehicle Main Screen
//##################################################################

class MyVehicle1 extends StatelessWidget {
  const MyVehicle1({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<MyVehicle1Controller>(
        init: MyVehicle1Controller(),
        global: false,
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: controller.myVehicleDetails.vehicleNumber,
                actions: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.backgroundColor,
                    ),
                    // child: TextButton(
                    //     onPressed: controller.onEditButtonTap,
                    //     child: Text(
                    //       AppLanguageTranslation
                    //           .editTranskey.toCurrentLanguage,
                    //       style: AppTextStyles.bodySmallSemiboldTextStyle
                    //           .copyWith(decoration: TextDecoration.underline),
                    //     )),
                  )
                ],
                hasBackButton: true),
            /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
            body: ScaffoldBodyWidget(
                child: CustomScrollView(slivers: [
              SliverToBoxAdapter(child: AppGaps.hGap15),
              SliverToBoxAdapter(
                child: Text(
                  controller.myVehicleDetails.brand.name,
                  style: AppTextStyles.titleSemiSmallBoldTextStyle
                      .copyWith(color: Colors.black),
                ),
              ),
              SliverToBoxAdapter(child: AppGaps.hGap8),
              SliverToBoxAdapter(
                child: Text(
                  controller.myVehicleDetails.category.name,
                  style: AppTextStyles.bodyLargeMediumTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
              ),
              SliverToBoxAdapter(child: AppGaps.hGap18),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        height: 160,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: controller.imageController,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.myVehicleDetails.images.length,
                                itemBuilder: (context, index) {
                                  final images =
                                      controller.myVehicleDetails.images[index];
                                  return CachedNetworkImageWidget(
                                    imageURL: images,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              AppComponents.imageBorderRadius,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SmoothPageIndicator(
                          controller: controller.imageController,
                          count: controller.myVehicleDetails.images.isEmpty
                              ? 1
                              : controller.myVehicleDetails.images.length,
                          axisDirection: Axis.horizontal,
                          effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 2,
                              expansionFactor: 3,
                              activeDotColor: AppColors.primaryColor,
                              dotColor:
                                  AppColors.primaryColor.withOpacity(0.3)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: AppGaps.hGap32),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  child: Obx(() => Row(
                        children: [
                          /* Expanded(
                              child: ListTabStatusWidget(
                            text: 'Specifications',
                            isSelected: controller.vehicleInfoStatusTab.value ==
                                VehicleDetailsInfoTypeStatus.specifications,
                            onTap: () {
                              controller.onTabTap(
                                  VehicleDetailsInfoTypeStatus.specifications);
                            },
                          )), */
                          AppGaps.wGap10,
                          Expanded(
                              child: ListTabStatusWidget(
                            text: 'Features',
                            isSelected: controller.vehicleInfoStatusTab.value ==
                                VehicleDetailsInfoTypeStatus.features,
                            onTap: () {
                              controller.onTabTap(
                                  VehicleDetailsInfoTypeStatus.features);
                            },
                          )),
                          AppGaps.wGap10,
                          Expanded(
                              child: ListTabStatusWidget(
                            text: 'Documents',
                            isSelected: controller.vehicleInfoStatusTab.value ==
                                VehicleDetailsInfoTypeStatus.documents,
                            onTap: () {
                              controller.onTabTap(
                                  VehicleDetailsInfoTypeStatus.documents);
                            },
                          )),
                        ],
                      )),
                ),
              ),
              SliverToBoxAdapter(child: AppGaps.hGap24),
              Obx(() {
                switch (controller.vehicleInfoStatusTab.value) {
                  case VehicleDetailsInfoTypeStatus.specifications:
                    return SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: AppColors.lineShapeColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.maxPower,
                                    height: 19,
                                  ),
                                  AppGaps.hGap2,
                                  Text('Max. power',
                                      style: AppTextStyles
                                          .smallestMediumTextStyle),
                                  AppGaps.hGap2,
                                  Text(
                                    '2500hp',
                                    style: AppTextStyles.smallestTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          )),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.lineShapeColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.maxSpeed,
                                    height: 19,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    'Max. speed',
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    '230kph',
                                    style: AppTextStyles.smallestTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.lineShapeColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.mileage,
                                    height: 19,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    'Mileage',
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    '10 km per litre',
                                    style: AppTextStyles.smallestTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                            child: Container(
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: AppColors.lineShapeColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssetImages.seat,
                                    height: 19,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    'Seat',
                                    style:
                                        AppTextStyles.smallestMediumTextStyle,
                                  ),
                                  AppGaps.hGap2,
                                  Text(
                                    '4 Seats',
                                    style: AppTextStyles.smallestTextStyle,
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    );
                  case VehicleDetailsInfoTypeStatus.features:
                    return SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Car features',
                          style: AppTextStyles.headlineLargeBoldTextStyle,
                        ),
                        AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'Model',
                          featuresvalue:
                              controller.myVehicleDetails.brandModel.name,
                        ),
                        /* AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'Model Year',
                          featuresvalue: '2019',
                        ), */
                        /* AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'Vehicle Color',
                          isColor: true,
                          color: controller.myVehicleDetails.color,
                        ), */
                        AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'Fuel Type',
                          featuresvalue: 'Petrol',
                        ),
                        AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'Gear Type',
                          featuresvalue: 'Manual',
                        ),
                        AppGaps.hGap16,
                        VehicleFeaturesWidget(
                          featuresName: 'AC',
                          featuresvalue: 'Yes',
                        ),
                        AppGaps.hGap16,
                        AppGaps.hGap16,
                      ],
                    ));
                  case VehicleDetailsInfoTypeStatus.documents:
                    return SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: 'Number Plate',
                            featuresvalue: '16587-akks',
                          ),
                          AppGaps.hGap24,
                          Text(
                            'Vehicle Registration .jPJ',
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                        ],
                      ),
                    );
                }
              })
            ]))));
  }
}

// class MyVehicle1 extends StatelessWidget {
//   const MyVehicle1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyVehicle1Controller>(
//         init: MyVehicle1Controller(),
//         global: false,
//         builder: (controller) => CustomScaffold(
//             appBar: CoreWidgets.appBarWidget(
//                 screenContext: context,
//                 titleText:
//                     AppLanguageTranslation.myVehicleTransKey.toCurrentLanguage,
//                 hasBackButton: true),
//             body: ScaffoldBodyWidget(
//                 child: Padding(
//               padding: const EdgeInsets.only(left: 5, top: 25),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                         child: SingleChildScrollView(
//                             child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                           Text(
//                             AppLanguageTranslation
//                                 .mustangShelbyGtTranskey.toCurrentLanguage,
//                             style: AppTextStyles.titleSemiSmallBoldTextStyle,
//                           ),
//                           Text(
//                             AppLanguageTranslation
//                                 .airConditionCarTranskey.toCurrentLanguage,
//                             style: AppTextStyles.bodyLargeMediumTextStyle
//                                 .copyWith(color: AppColors.bodyTextColor),
//                           ),
//                           Center(
//                             child: Image.asset(AppAssetImages.carImage,
//                                 height: 154, width: 287),
//                           ),
//                           SettingsListTileWidget(
//                             titleText: AppLanguageTranslation
//                                 .documentTranskey.toCurrentLanguage,
//                             onTap: () {
//                               Get.toNamed(
//                                   AppPageNames.changePasswordPromptScreen);
//                             },
//                             settingsValueTextWidget: Text(''),
//                           ),
//                           AppGaps.hGap20,
//                           SettingsListTileWidget(
//                             titleText: AppLanguageTranslation
//                                 .informationTranskey.toCurrentLanguage,
//                             onTap: () {
//                               Get.toNamed(
//                                   AppPageNames.changePasswordPromptScreen);
//                             },
//                             settingsValueTextWidget: Text(''),
//                           ),
//                           AppGaps.hGap20,
//                           InkWell(
//                             onTap: () {},
//                             child: Text(
//                               AppLanguageTranslation
//                                   .removeThisVehicleTransKey.toCurrentLanguage,
//                               style: AppTextStyles.bodyBoldTextStyle
//                                   .copyWith(color: Colors.red),
//                             ),
//                           )
//                         ])))
//                   ]),
//             ))));
//   }
// }
