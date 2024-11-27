import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/start_ride_bottomsheet_controller.dart';
import 'package:taxiappdriver/screens/bottom_sheet/submit_otp_screen_bottomsheet.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class StartRideBottomSheetScreen extends StatelessWidget {
  const StartRideBottomSheetScreen({super.key});
//========same===========
  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<StartRideBottomSheetController>(
        global: false,
        init: StartRideBottomSheetController(),
        builder: (controller) => Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                /* <-------- 10px height gap --------> */
                AppGaps.hGap10,
                Container(
                  height: 2,
                  width: 60,
                  color: Colors.grey,
                ),
                /* <-------- 24px height gap --------> */
                AppGaps.hGap24,
                Expanded(
                    child: SingleChildScrollView(
                  /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                  child: ScaffoldBodyWidget(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  height: 87,
                                  decoration: const BoxDecoration(
                                      color: AppColors.fieldbodyColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Row(children: [
                                    SizedBox(
                                      height: 48,
                                      width: 48,
                                      /* <-------- Fetch user image from API --------> */
                                      child: CachedNetworkImageWidget(
                                        imageURL:
                                            controller.rideDetails.user.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    /* <-------- 16px width gap --------> */
                                    AppGaps.wGap16,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.rideDetails.user.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle,
                                          ),
                                          /* <-------- 7px height gap --------> */
                                          /* AppGaps.hGap7,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColors.primaryColor,
                                              ),
                                              AppGaps.wGap4,
                                              Expanded(
                                                child: Text(
                                                  '${5} (520 reviews)',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              Helper
                                                  .getCurrencyFormattedWithDecimalAmountText(
                                                      controller
                                                          .rideDetails.total),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodySemiboldTextStyle,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${controller.rideDetails.distance.text}, ${controller.rideDetails.duration.text}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                                    /* Row(
                                      children: [
                                        RawButtonWidget(
                                          borderRadiusValue: 12,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryBorderColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12))),
                                            child: const Center(
                                                child: SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .messageFilSVGLogoSolid)),
                                          ),
                                          onTap: () {},
                                        ),
                                        AppGaps.wGap8,
                                        RawButtonWidget(
                                          borderRadiusValue: 12,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryBorderColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12))),
                                            child: const Center(
                                                child: SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .callingSVGLogoSolid)),
                                          ),
                                          onTap: () {},
                                        )
                                      ],
                                    ) */
                                  ]),
                                ),
                              )
                            ],
                          ),
                          AppGaps.hGap16,
                          Row(
                            children: [
                              RawButtonWidget(
                                borderRadiusValue: 12,
                                child: Container(
                                  height: 54,
                                  width: 54,
                                  decoration: BoxDecoration(
                                      // color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2)),
                                      border: Border.all(
                                          color: AppColors.fromBorderColor)),
                                  child: const Center(
                                      child: Icon(Icons.call,
                                          color: AppColors.primaryColor,
                                          size: 20)),
                                ),
                                onTap: () {
                                  launchUrl(Uri(
                                      scheme: 'tel',
                                      path: controller.rideDetails.user.phone));
                                },
                              ),
                              AppGaps.wGap10,
                              Expanded(
                                child: CustomMessageTextFormField(
                                  boxHeight: 44,
                                  isReadOnly: true,
                                  onTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments:
                                            controller.rideDetails.user.id);
                                  },
                                  hintText: 'Type Your Message',
                                  suffixIcon: Icon(Icons.send,
                                      color: AppColors.primaryColor, size: 20),
                                ),
                              )
                            ],
                          ),
                          /* <-------- 16px height gap --------> */
                          AppGaps.hGap16,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  height: 185,
                                  decoration: const BoxDecoration(
                                      color: AppColors.fieldbodyColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Start Time',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            Helper
                                                .ddMMMyyyyhhmmaFormattedDateTime(
                                                    controller
                                                        .rideDetails.date),
                                            // need update
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeMediumTextStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                    AppGaps.hGap12,
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              const SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .location1SVGLogoLine,
                                                color: AppColors.bodyTextColor,
                                                height: 20,
                                                width: 20,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                width: 1,
                                                color: AppColors.hintTextColor,
                                              ),
                                              const SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .location2SVGLogoLine,
                                                color: AppColors.bodyTextColor,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          /* <-------- 4px width gap --------> */
                                          AppGaps.wGap4,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                      .rideDetails.from.address,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeMediumTextStyle,
                                                ),
                                                AppGaps.hGap8,
                                                Container(
                                                  color:
                                                      AppColors.hintTextColor,
                                                  height: 1,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.32,
                                                ),
                                                AppGaps.hGap24,
                                                Text(
                                                  'Drop Location',
                                                  style: AppTextStyles
                                                      .bodySmallTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .bodyTextColor),
                                                ),
                                                /* <-------- 4px height gap --------> */
                                                AppGaps.hGap4,
                                                Text(
                                                  controller
                                                      .rideDetails.to.address,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeMediumTextStyle,
                                                )
                                              ],
                                            ),
                                          )
                                        ])
                                  ]),
                                ),
                              )
                            ],
                          ),
                          /* <-------- 32px height gap --------> */
                          AppGaps.hGap32,
                          Row(
                            children: [
                              Expanded(
                                  child: RawButtonWidget(
                                      child: Container(
                                        height: 44,
                                        width: 112,
                                        decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: AppColors.primaryColor)),
                                        child: const Center(
                                            child: Text(
                                          'Cancle',
                                          style: TextStyle(
                                              color: AppColors.primaryColor),
                                        )),
                                      ),
                                      onTap: () async {
                                        controller.onBottomButtonTap();
                                      })),
                              /* <-------- 16px width gap --------> */
                              AppGaps.wGap16,
                              Expanded(
                                  child: RawButtonWidget(
                                child: Container(
                                  height: 44,
                                  width: 112,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Center(
                                      child: Text(
                                    'Start',
                                    style: TextStyle(
                                        color: AppColors.backgroundColor),
                                  )),
                                ),
                                onTap: () {
                                  Get.back(result: true);
                                  Get.bottomSheet(
                                      const SubmitOtpStartRideBottomSheet(),
                                      settings: RouteSettings(
                                          arguments: controller.rideDetails));
                                },
                              ))
                            ],
                          ),
                          /* <-------- 30px height gap --------> */
                          AppGaps.hGap30,
                        ]),
                  ),
                ))
              ]),
            ));
  }
}
