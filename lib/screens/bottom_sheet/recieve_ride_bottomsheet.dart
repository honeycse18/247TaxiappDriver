import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/history_ride_screen_bottomsheet_controller.dart';
import 'package:taxiappdriver/model/enums.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ReceiveRideBottomSheetScreen extends StatelessWidget {
  const ReceiveRideBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<AcceptRideBottomSheetController>(
        init: AcceptRideBottomSheetController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.50,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        imageURL: controller
                                            .rideShareRequestDetails.user.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
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
                                            controller.rideShareRequestDetails
                                                .user.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodySemiboldTextStyle,
                                          ),
                                          /* <-------- 8px height gap --------> */
                                          /* AppGaps.hGap8,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColors.primaryColor,
                                                size: 16,
                                              ),
                                              /* <-------- 4px width gap --------> */
                                              AppGaps.wGap4,
                                              Expanded(
                                                child: Text(
                                                  '${controller.fakeRideHistoryData.review} (520 Reviews)',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .smallestTextStyle
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
                                              Helper.getCurrencyFormattedWithDecimalAmountText(
                                                  controller
                                                      .rideShareRequestDetails
                                                      .total),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeBoldTextStyle,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${controller.rideShareRequestDetails.distance.text}, ${controller.rideShareRequestDetails.duration.text}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodySmallMediumTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
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
                                  padding: const EdgeInsets.all(16),
                                  height: 180,
                                  decoration: const BoxDecoration(
                                      color: AppColors.fieldbodyColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Column(children: [
                                    controller.rideShareRequestDetails.schedule
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  AppLanguageTranslation
                                                      .startDateTimeTranskey
                                                      .toCurrentLanguage,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .bodyTextColor),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  Helper.ddMMMyyyyhhmmFormattedDateTime(
                                                      controller
                                                          .rideShareRequestDetails
                                                          .date),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .bodyLargeMediumTextStyle,
                                                ),
                                              )
                                            ],
                                          )
                                        : AppGaps.emptyGap,
                                    /* <-------- 12px height gap --------> */
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
                                              height: 20,
                                              width: 20,
                                              color: AppColors.bodyTextColor,
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
                                              height: 20,
                                              width: 20,
                                              color: AppColors.bodyTextColor,
                                            ),
                                          ],
                                        ),
                                        AppGaps.wGap8,
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
                                              AppGaps.hGap4,
                                              Text(
                                                controller
                                                    .rideShareRequestDetails
                                                    .from
                                                    .address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .bodyLargeMediumTextStyle,
                                              ),
                                              AppGaps.hGap12,
                                              Container(
                                                color: AppColors.hintTextColor,
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.32,
                                              ),
                                              AppGaps.hGap20,
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
                                                    .rideShareRequestDetails
                                                    .to
                                                    .address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles
                                                    .bodyLargeMediumTextStyle,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
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
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.primaryColor)),
                                  child: Center(
                                      child: Text(
                                    'Decline',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  )),
                                ),
                                onTap: () => controller.acceptRejectRideRequest(
                                    controller.rideShareRequestDetails.id,
                                    RideStatus.rejected),
                              )),
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
                                    '${AppLanguageTranslation.acceptTransKey.toCurrentLanguage}  →',
                                    style: TextStyle(
                                        color: AppColors.backgroundColor),
                                  )),
                                ),
                                onTap: () async {
                                  await controller.acceptRejectRideRequest(
                                      controller.rideShareRequestDetails.id,
                                      RideStatus.accepted);

                                  Get.back();
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
