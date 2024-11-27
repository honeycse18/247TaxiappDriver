import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taxiappdriver/controller/start_ride_request_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StartRideRequestScreen extends StatelessWidget {
  const StartRideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<StartRequestScreenController>(
        init: StartRequestScreenController(),
        global: false,
        builder: ((controller) => PopScope(
              onPopInvoked: (didPop) {
                controller.onClose();
              },
              child: Scaffold(
                // key: controller.bottomSheetFormKey,
                extendBodyBehindAppBar: true,
                extendBody: true,
                backgroundColor: AppColors.backgroundColor,
                /* <-------- AppBar --------> */
                appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: false,
                  titleText: AppLanguageTranslation
                      .rideDetailsTransKey.toCurrentLanguage,
                ),
                /* <-------- Body Content --------> */
                body: Stack(
                  children: [
                    Positioned.fill(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationEnabled: false,
                          compassEnabled: true,
                          zoomGesturesEnabled: true,
                          initialCameraPosition:
                              // AppSingleton.instance.defaultCameraPosition,
                              CameraPosition(
                                  target: LatLng(
                                      (controller.cameraPosition.latitude) -
                                          7.7,
                                      controller.cameraPosition.longitude),
                                  zoom: controller.zoomLevel),
                          markers: controller.googleMapMarkers,
                          polylines: controller.googleMapPolyLines,
                          onMapCreated: controller.onGoogleMapCreated,
                          // onTap: controller.onGoogleMapTap,
                        ),
                      ),
                    ),
                    SlidingUpPanel(
                      defaultPanelState: PanelState.OPEN,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.transparent,
                      boxShadow: null,
                      minHeight: MediaQuery.of(context).size.height * 0.26,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                      footer: Container(
                        width: context.width,
                        child: ScaffoldBodyWidget(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              return switch (controller.status.value) {
                                'accepted' => Row(
                                    children: [
                                      Expanded(
                                        child:
                                            CustomStretchedOutlinedButtonWidget(
                                          bordercolor: AppColors.primaryColor,
                                          onTap:
                                              controller.onCancelTripButtonTap,
                                          child: Text(
                                            'Cancel',
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle
                                                .copyWith(
                                                    color:
                                                        AppColors.alertColor),
                                          ),
                                        ),
                                      ),
                                      /* <-------- 15px width gap --------> */
                                      AppGaps.wGap15,
                                      /* <-------- Start trip button --------> */
                                      Expanded(
                                        child: CustomStretchedTextButtonWidget(
                                          isLoading: controller.isLoading,
                                          buttonText: 'Start Trip',
                                          onTap:
                                              controller.onStartTripButtonTap,
                                        ),
                                      )
                                    ],
                                  ),
                                'started' => CustomStretchedTextButtonWidget(
                                    isLoading: controller.isLoading,
                                    buttonText: 'Reached',
                                    onTap: controller.reachedTrip),
                                'reached' => CustomStretchedTextButtonWidget(
                                    isLoading: controller.isLoading,
                                    buttonText: 'Complete Trip',
                                    onTap: controller.paymentId.isNotEmpty ||
                                            controller.ridePrimaryDetails
                                                    .payment.method ==
                                                'cash'
                                        ? controller.completeTrip
                                        : null,
                                  ),
                                'completed' => CustomStretchedTextButtonWidget(
                                    isLoading: controller.isLoading,
                                    buttonText: AppLanguageTranslation
                                        .submitReviewTransKey.toCurrentLanguage,
                                    onTap: () {},
                                  ),
                                'cancelled' => Text(
                                    controller.cancelReason,
                                    style: AppTextStyles.semiSmallXBoldTextStyle
                                        .copyWith(color: AppColors.errorColor),
                                  ),
                                _ => SizedBox(),
                              };
                              /* return controller.status.value == 'accepted'
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child:
                                              CustomStretchedOutlinedButtonWidget(
                                            bordercolor: AppColors.primaryColor,
                                            onTap:
                                                controller.onCancelTripButtonTap,
                                            child: Text(
                                              'Cancel',
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.alertColor),
                                            ),
                                          ),
                                        ),
                                        /* <-------- 15px width gap --------> */
                                        AppGaps.wGap15,
                                        /* <-------- Start trip button --------> */
                                        Expanded(
                                          child: CustomStretchedTextButtonWidget(
                                            isLoading: controller.isLoading,
                                            buttonText: 'Start Trip',
                                            onTap:
                                                controller.onStartTripButtonTap,
                                          ),
                                        )
                                      ],
                                    )
                                  : controller.status.value == 'started'
                                      ? controller.status.value != 'reached'
                                          ? CustomStretchedTextButtonWidget(
                                              isLoading: controller.isLoading,
                                              buttonText: 'Reached',
                                              onTap: controller.reachedTrip)
                                          : CustomStretchedTextButtonWidget(
                                              isLoading: controller.isLoading,
                                              buttonText: 'Complete Trip',
                                              onTap: controller
                                                          .paymentId.isNotEmpty ||
                                                      controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method ==
                                                          'cash'
                                                  ? controller.completeTrip
                                                  : null,
                                            )
                                      : controller.status.value == 'completed'
                                          ? CustomStretchedTextButtonWidget(
                                              isLoading: controller.isLoading,
                                              buttonText: AppLanguageTranslation
                                                  .submitReviewTransKey
                                                  .toCurrentLanguage,
                                              onTap: () {},
                                            )
                                          : controller.status.value == 'cancelled'
                                              ? Text(
                                                  controller.cancelReason,
                                                  style: AppTextStyles
                                                      .semiSmallXBoldTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .errorColor),
                                                )
                                              : AppGaps.emptyGap; */
                            }),
                            /* <-------- 20px height gap --------> */
                            AppGaps.hGap10
                          ],
                        )),
                      ),
                      panel: Stack(
                        children: [
                          Positioned(
                              top: 5,
                              left: 20,
                              child: RawButtonWidget(
                                onTap: () async {
                                  try {
                                    final currentLocation = LatLng(
                                        controller.ridePrimaryDetails.from
                                            .location.lat,
                                        controller.ridePrimaryDetails.from
                                            .location.lng);
                                    final destinationLocation = LatLng(
                                        controller
                                            .ridePrimaryDetails.to.location.lat,
                                        controller.ridePrimaryDetails.to
                                            .location.lng);
                                    final googleMapsUrl =
                                        'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&travelmode=driving';

                                    if (await canLaunch(googleMapsUrl)) {
                                      await launch(googleMapsUrl);
                                    } else {
                                      throw 'Could not launch $googleMapsUrl';
                                    }
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                },
                                child: Container(
                                  width: 90,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.near_me,
                                            size: 20,
                                            color: AppColors.primaryColor),
                                        Text(
                                          'Navigate',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppColors.primaryTextColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 73.0),
                            child: Container(
                              // margin: EdgeInsets.only(right: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: AppColors.backgroundColor,
                              ),
                              child: Column(children: [
                                /* <-------- 12px height gap --------> */
                                AppGaps.hGap12,
                                Container(
                                  height: 2,
                                  width: 60,
                                  color: Colors.grey,
                                ),
                                /* <-------- 24px height gap --------> */
                                AppGaps.hGap24,
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: ScaffoldBodyWidget(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 14),
                                                  height: 95,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: AppColors
                                                              .fieldbodyColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                  child: Row(children: [
                                                    SizedBox(
                                                      height: 48,
                                                      width: 48,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                        imageURL: controller
                                                                .ridePrimaryDetails
                                                                .user
                                                                .image
                                                                .isEmpty
                                                            ? controller
                                                                .rideHistoryData
                                                                .user
                                                                .image
                                                            : controller
                                                                .ridePrimaryDetails
                                                                .user
                                                                .image,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      ),
                                                    ),
                                                    AppGaps.wGap16,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            controller
                                                                    .ridePrimaryDetails
                                                                    .user
                                                                    .name
                                                                    .isEmpty
                                                                ? controller
                                                                    .rideHistoryData
                                                                    .user
                                                                    .name
                                                                : controller
                                                                    .ridePrimaryDetails
                                                                    .user
                                                                    .name,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodyLargeSemiboldTextStyle,
                                                          ),
                                                          AppGaps.hGap7,
                                                          /*  Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                size: 15,
                                                                color: AppColors
                                                                    .statusTextColor,
                                                              ),
                                                              /*  const SvgPictureAssetWidget(
                                                                AppAssetImages
                                                                    .starSVGLogoSolid,
                                                                height: 10,
                                                                width: 10,
                                                                color: AppColors
                                                                    .primaryButtonColor,
                                                              ), */
                                                              AppGaps.wGap4,
                                                              Expanded(
                                                                child: Text(
                                                                  '${5} (1 reviews)',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppTextStyles
                                                                      .bodySmallTextStyle
                                                                      .copyWith(
                                                                          color: AppColors
                                                                              .bodyTextColor),
                                                                ),
                                                              ),
                                                            ],
                                                          ), */
                                                        ],
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              Helper.getCurrencyFormattedWithDecimalAmountText(controller
                                                                          .ridePrimaryDetails
                                                                          .total ==
                                                                      0
                                                                  ? controller
                                                                      .rideHistoryData
                                                                      .total
                                                                  : controller
                                                                      .ridePrimaryDetails
                                                                      .total),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyles
                                                                  .bodySemiboldTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${controller.ridePrimaryDetails.distance.text.isEmpty ? controller.rideHistoryData.distance.text : controller.ridePrimaryDetails.distance.text}, ${controller.ridePrimaryDetails.duration.text.isEmpty ? controller.rideHistoryData.duration.text : controller.ridePrimaryDetails.duration.text}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: AppTextStyles
                                                                  .bodySmallTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .bodyTextColor),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                                ),
                                              )
                                            ],
                                          ),

                                          /* <-------- 16px height gap --------> */
                                          AppGaps.hGap16,

                                          /* <-------- 20px height gap --------> */
                                          AppGaps.hGap10,
                                          if (controller
                                                  .ridePrimaryDetails.status ==
                                              'accepted')
                                            Row(
                                              children: [
                                                RawButtonWidget(
                                                  borderRadiusValue: 12,
                                                  child: Container(
                                                    height: 54,
                                                    width: 54,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    4)),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .fromBorderColor)),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.call,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                  ),
                                                  onTap: () {
                                                    launchUrl(Uri(
                                                        scheme: 'tel',
                                                        path: controller
                                                            .ridePrimaryDetails
                                                            .user
                                                            .phone));
                                                  },
                                                ),
                                                AppGaps.wGap10,
                                                Expanded(
                                                  child:
                                                      CustomMessageTextFormField(
                                                    boxHeight: 44,
                                                    isReadOnly: true,
                                                    onTap: () {
                                                      Get.toNamed(
                                                          AppPageNames
                                                              .chatScreen,
                                                          arguments: controller
                                                              .ridePrimaryDetails
                                                              .user
                                                              .id);
                                                    },
                                                    hintText:
                                                        'Type Your Message',
                                                    suffixIcon: const Icon(
                                                      Icons.send,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          AppGaps.hGap6,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              RawButtonWidget(
                                                child: const Icon(
                                                    Icons.restore_outlined),
                                                onTap: () {
                                                  controller.getRideDetails();
                                                  controller.update();
                                                },
                                              ),
                                            ],
                                          ),
                                          /* <-------- 6px height gap --------> */
                                          AppGaps.hGap6,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  height: 168,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: AppColors
                                                              .fieldbodyColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                  child: Column(children: [
                                                    /* Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            AppLanguageTranslation
                                                                .startDateTimeTranskey
                                                                .toCurrentLanguage,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodyLargeTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .bodyTextColor),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            Helper.ddMMMyyyyhhmmaFormattedDateTime(
                                                                controller
                                                                    .ridePrimaryDetails
                                                                    .date),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppTextStyles
                                                                .bodyLargeMediumTextStyle,
                                                          ),
                                                        )
                                                      ],
                                                    ), */
                                                    /* <-------- 12px height gap --------> */
                                                    AppGaps.hGap12,
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            const SvgPictureAssetWidget(
                                                              AppAssetImages
                                                                  .currentLocationSVGLogoLine,
                                                              height: 16,
                                                              width: 16,
                                                              color: AppColors
                                                                  .bodyTextColor,
                                                            ),
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.08,
                                                              width: 1,
                                                              color: AppColors
                                                                  .bodyTextColor,
                                                            ),
                                                            const SvgPictureAssetWidget(
                                                              AppAssetImages
                                                                  .pickLocationSVGLogoLine,
                                                              height: 16,
                                                              width: 16,
                                                              color: AppColors
                                                                  .bodyTextColor,
                                                            ),
                                                          ],
                                                        ),
                                                        AppGaps.wGap8,
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Pickup Location',
                                                                style: AppTextStyles
                                                                    .bodySmallTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .bodyTextColor),
                                                              ),
                                                              /* <-------- 6px height gap --------> */
                                                              AppGaps.hGap6,
                                                              Text(
                                                                controller
                                                                        .ridePrimaryDetails
                                                                        .from
                                                                        .address
                                                                        .isEmpty
                                                                    ? controller
                                                                        .rideHistoryData
                                                                        .from
                                                                        .address
                                                                    : controller
                                                                        .ridePrimaryDetails
                                                                        .from
                                                                        .address,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles
                                                                    .bodyLargeMediumTextStyle,
                                                              ),
                                                              AppGaps.hGap6,
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          Container(
                                                                    color: AppColors
                                                                        .bodyTextColor,
                                                                    height: 1,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.30,
                                                                  )),
                                                                  Container(
                                                                    width: 65,
                                                                    height: 28,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            5),
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: Color(
                                                                          0xFF919BB3),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                      controller
                                                                          .ridePrimaryDetails
                                                                          .distance
                                                                          .text,
                                                                      style: AppTextStyles
                                                                          .bodySmallMediumTextStyle
                                                                          .copyWith(
                                                                              color: Colors.white),
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                'Drop Location',
                                                                style: AppTextStyles
                                                                    .bodySmallTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .bodyTextColor),
                                                              ),
                                                              AppGaps.hGap4,
                                                              Text(
                                                                controller
                                                                        .ridePrimaryDetails
                                                                        .to
                                                                        .address
                                                                        .isEmpty
                                                                    ? controller
                                                                        .rideHistoryData
                                                                        .to
                                                                        .address
                                                                    : controller
                                                                        .ridePrimaryDetails
                                                                        .to
                                                                        .address,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles
                                                                    .bodyLargeMediumTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    /* <-------- 5px height gap --------> */
                                                    AppGaps.hGap5,

                                                    /* <-------- 5px height gap --------> */
                                                    AppGaps.hGap5,
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          AppGaps.hGap24,
                                          if (controller.paymentId.isNotEmpty ||
                                              controller.ridePrimaryDetails
                                                      .payment.method ==
                                                  'cash')
                                            const Text(
                                              'Payment Method',
                                              style: AppTextStyles
                                                  .bodyLargeMediumTextStyle,
                                            ),
                                          /* <-------- 8px height gap --------> */
                                          AppGaps.hGap8,
                                          if (controller.paymentId.isNotEmpty ||
                                              controller.ridePrimaryDetails
                                                      .payment.method ==
                                                  'cash')
                                            RawButtonWidget(
                                              borderRadiusValue: 14,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 50,
                                                width: 125,
                                                decoration: const BoxDecoration(
                                                    color: AppColors
                                                        .fieldbodyColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                14))),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller
                                                                  .ridePrimaryDetails
                                                                  .payment
                                                                  .method ==
                                                              'wallet'
                                                          ? const Icon(
                                                              Icons
                                                                  .attach_money,
                                                              size: 24,
                                                            )
                                                          : controller
                                                                      .ridePrimaryDetails
                                                                      .payment
                                                                      .method ==
                                                                  'paypal'
                                                              ? const Icon(
                                                                  Icons.paypal,
                                                                  size: 24,
                                                                )
                                                              : const Icon(
                                                                  Icons.money,
                                                                  size: 24,
                                                                ),
                                                      /* SvgPictureAssetWidget(
                                                            AppAssetImages
                                                                .dollarSVGLogoSolid), */
                                                      /* <-------- 6px width gap --------> */
                                                      AppGaps.wGap6,
                                                      Text(
                                                        controller
                                                            .ridePrimaryDetails
                                                            .payment
                                                            .method
                                                            .toUpperCase(),
                                                        style: AppTextStyles
                                                            .bodyLargeMediumTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                          if (controller.paymentId.isNotEmpty ||
                                              controller.ridePrimaryDetails
                                                      .payment.method ==
                                                  'cash')
                                            AppGaps.hGap18,
                                          if (controller.paymentId.isNotEmpty ||
                                              controller.ridePrimaryDetails
                                                      .payment.method ==
                                                  'cash')
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  height: controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method !=
                                                          'cash'
                                                      ? 220
                                                      : 170,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors
                                                        .fieldbodyColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLanguageTranslation
                                                            .fareDetailsTranskey
                                                            .toCurrentLanguage,
                                                        style: AppTextStyles
                                                            .bodyLargeBoldTextStyle,
                                                      ),
                                                      AppGaps.hGap8,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              AppLanguageTranslation
                                                                  .fareTranskey
                                                                  .toCurrentLanguage,
                                                              style: AppTextStyles
                                                                  .bodyTextStyle,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .userDetailsData
                                                                    .currency
                                                                    .symbol,
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                              /* <-------- 2px width gap --------> */
                                                              AppGaps.wGap2,
                                                              Text(
                                                                controller
                                                                    .ridePrimaryDetails
                                                                    .subTotal
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      /* <-------- 8px height gap --------> */
                                                      AppGaps.hGap8,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                              'Coupon Discount',
                                                              style: AppTextStyles
                                                                  .bodyTextStyle,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .userDetailsData
                                                                    .currency
                                                                    .symbol,
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                              /* <-------- 2px height gap --------> */
                                                              AppGaps.wGap2,
                                                              Text(
                                                                controller
                                                                    .ridePrimaryDetails
                                                                    .couponDiscount
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      AppGaps.hGap8,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                              'Extra Luggage Cost',
                                                              style: AppTextStyles
                                                                  .bodyTextStyle,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .userDetailsData
                                                                    .currency
                                                                    .symbol,
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                              /* <-------- 2px height gap --------> */
                                                              AppGaps.wGap2,
                                                              Text(
                                                                controller
                                                                    .ridePrimaryDetails
                                                                    .extraLuggageCost
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: AppTextStyles
                                                                    .bodyTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      /* <-------- 8px height gap --------> */
                                                      AppGaps.hGap8,
                                                      const Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  DottedHorizontalLine(
                                                            dashLength: 12,
                                                            dashGapLength: 4,
                                                            dashColor: AppColors
                                                                .fromBorderColor,
                                                          )),
                                                        ],
                                                      ),
                                                      /* <-------- 8px height gap --------> */
                                                      AppGaps.hGap8,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              AppLanguageTranslation
                                                                  .totalFareTranskey
                                                                  .toCurrentLanguage,
                                                              style: AppTextStyles
                                                                  .bodyLargeSemiboldTextStyle,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                controller
                                                                    .userDetailsData
                                                                    .currency
                                                                    .symbol,
                                                                style: AppTextStyles
                                                                    .bodyLargeSemiboldTextStyle,
                                                              ),
                                                              /* <-------- 2px width gap --------> */
                                                              AppGaps.wGap2,
                                                              Text(
                                                                controller
                                                                    .ridePrimaryDetails
                                                                    .total
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: AppTextStyles
                                                                    .bodyLargeSemiboldTextStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      if (controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method !=
                                                          'cash')
                                                        /* <-------- 8px height gap --------> */
                                                        AppGaps.hGap8,
                                                      if (controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method !=
                                                          'cash')
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                AppLanguageTranslation
                                                                    .paidTranskey
                                                                    .toCurrentLanguage,
                                                                style: AppTextStyles
                                                                    .bodySemiboldTextStyle,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .userDetailsData
                                                                      .currency
                                                                      .symbol,
                                                                  style: AppTextStyles
                                                                      .bodySemiboldTextStyle,
                                                                ),
                                                                /* <-------- 2px width gap --------> */
                                                                AppGaps.wGap2,
                                                                Text(
                                                                  controller
                                                                      .ridePrimaryDetails
                                                                      .payment
                                                                      .amount
                                                                      .toStringAsFixed(
                                                                          2),
                                                                  style: AppTextStyles
                                                                      .bodySemiboldTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      if (controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method !=
                                                          'cash')
                                                        AppGaps.hGap8,
                                                      if (controller
                                                              .ridePrimaryDetails
                                                              .payment
                                                              .method !=
                                                          'cash')
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              'Payment Status',
                                                              style: AppTextStyles
                                                                  .bodySemiboldTextStyle,
                                                            ),
                                                            Text(
                                                              '${controller.ridePrimaryDetails.payment.status.capitalizeFirst}',
                                                              style: AppTextStyles.bodySemiboldTextStyle.copyWith(
                                                                  color: controller
                                                                              .ridePrimaryDetails.payment.status ==
                                                                          'pending'
                                                                      ? AppColors
                                                                          .errorColor
                                                                      : AppColors
                                                                          .successColor),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ))
                                              ],
                                            ),
                                          /* <-------- 100px height gap --------> */
                                          AppGaps.hGap100,
                                        ]),
                                  ),
                                ))
                              ]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                /* <-------- 24px height gap --------> */
              ),
            )));
  }
}
