import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taxiappdriver/controller/my_vehicle_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/Tab_list_screen_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class MyVehicleInformationScreen extends StatelessWidget {
  const MyVehicleInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<MyVehicleInformationScreenController>(
        init: MyVehicleInformationScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'My Vehicle',
                  hasBackButton: true),
              /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
              body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.vehicleId != ''
                          ? Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* <-------- 15px height gap --------> */
                                    AppGaps.hGap15,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${controller.myVehicleDetails.brand.name.capitalizeFirst}',
                                              style: AppTextStyles
                                                  .titleSemiSmallSemiboldTextStyle
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            Text(
                                              controller.myVehicleDetails
                                                  .category.name,
                                              style: AppTextStyles
                                                  .bodyLargeMediumTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          height: 30,
                                          // width: 65,
                                          color: controller.myVehicleDetails
                                                      .status ==
                                                  'approved'
                                              ? AppColors.successColor
                                                  .withOpacity(0.1)
                                              : controller.myVehicleDetails
                                                          .status ==
                                                      'suspended'
                                                  ? Colors.red.withOpacity(0.1)
                                                  : AppColors.statusColor
                                                      .withOpacity(0.9),
                                          child: Center(
                                            child: Text(
                                              '${controller.myVehicleDetails.status.capitalizeFirst}',
                                              style: TextStyle(
                                                  color: controller
                                                              .myVehicleDetails
                                                              .status ==
                                                          'approved'
                                                      ? AppColors.successColor
                                                      : controller.myVehicleDetails
                                                                  .status ==
                                                              'suspended'
                                                          ? Colors.red
                                                          : AppColors
                                                              .statusTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    /* <-------- 18px height gap --------> */
                                    AppGaps.hGap18,
                                    SizedBox(
                                      height: 180,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          Container(
                                            height: 160,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: PageView.builder(
                                                    controller: controller
                                                        .imageController,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: controller
                                                        .myVehicleDetails
                                                        .images
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final images = controller
                                                          .myVehicleDetails
                                                          .images[index];
                                                      return CachedNetworkImageWidget(
                                                        imageURL: images,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  AppComponents
                                                                      .imageBorderRadius,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover)),
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
                                              controller:
                                                  controller.imageController,
                                              count: controller.myVehicleDetails
                                                      .images.isEmpty
                                                  ? 1
                                                  : controller.myVehicleDetails
                                                      .images.length,
                                              axisDirection: Axis.horizontal,
                                              effect: ExpandingDotsEffect(
                                                  dotHeight: 8,
                                                  dotWidth: 8,
                                                  spacing: 2,
                                                  expansionFactor: 3,
                                                  activeDotColor:
                                                      AppColors.primaryColor,
                                                  dotColor: AppColors
                                                      .primaryColor
                                                      .withOpacity(0.3)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* <-------- 32px height gap --------> */
                                    AppGaps.hGap32,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RawButtonWidget(
                                            onTap: controller.onEditButtonTap,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 12,
                                              ),
                                              height: 56,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColors.curveColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(2))),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Information',
                                                    style: AppTextStyles
                                                        .bodyLargeMediumTextStyle,
                                                  ),
                                                  Icon(Icons
                                                      .arrow_forward_ios_rounded)
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    AppGaps.hGap24,
                                    if (controller.myVehicleDetails.status ==
                                        'suspended')
                                      const Text(
                                        'Suspend Reason',
                                        style: AppTextStyles.semiBoldTextStyle,
                                      ),
                                    if (controller.myVehicleDetails.status ==
                                        'suspended')
                                      AppGaps.hGap8,
                                    if (controller.myVehicleDetails.status ==
                                        'suspended')
                                      Text(
                                        '${controller.myVehicleDetails.suspendedReason.capitalizeFirst}',
                                        style: AppTextStyles.bodyTextStyle,
                                        textAlign: TextAlign.justify,
                                      ),
                                  ],
                                ),
                              ),
                            )
                          : EmptyScreenWidget(
                              localImageAssetURL: AppAssetImages.carImage,
                              title: 'You have not added any vehicle'),
                    ],
                  )),
              floatingActionButton: controller.vehicleId == ''
                  ? FloatingActionButton.extended(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      onPressed: controller.onAddButtonTap,
                      label: Text('+ Add Car',
                          style: AppTextStyles.bodyLargeSemiboldTextStyle
                              .copyWith(color: Colors.white)),
                    )
                  : AppGaps.emptyGap,
            ));
  }
}
