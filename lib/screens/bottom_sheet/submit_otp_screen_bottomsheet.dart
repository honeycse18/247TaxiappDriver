import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/submit_otp_start_trip_bottomsheet_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class SubmitOtpStartRideBottomSheet extends StatelessWidget {
  const SubmitOtpStartRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<SubmitOtpStartRideBottomSheetController>(
        init: SubmitOtpStartRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 12,
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: 60,
                    height: 2,
                    color: Colors.grey,
                  ),
                  /* <-------- 27px height gap --------> */
                  AppGaps.hGap27,
                  Row(
                    children: [
                      RawButtonWidget(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: const Center(
                              child: SvgPictureAssetWidget(
                            AppAssetImages.arrowLeftSVGLogoLine,
                            color: AppColors.primaryTextColor,
                          )),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      const Spacer(),
                      const Text(
                        'Submit OTP',
                        style: AppTextStyles.titleBoldTextStyle,
                      ),
                      /* <-------- 30px width gap --------> */
                      AppGaps.wGap30,
                      const Spacer(),
                    ],
                  ),
                  /* <-------- 27px height gap --------> */
                  AppGaps.hGap27,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Enter OTP',
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                      /* <-------- 4px width gap --------> */
                      AppGaps.wGap4,
                      Text(
                        '(User Provide this OTP)',
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ],
                  ),
                  /* <-------- 8px height gap --------> */
                  AppGaps.hGap8,
                  /* <-------- Phone Number Input Field --------> */
                  CustomTextFormField(
                    textInputType: TextInputType.number,
                    controller: controller.otpTextEditingController,
                    hintText: 'eg,0515',
                  ),
                  /* <-------- 32px height gap --------> */
                  AppGaps.hGap32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ActionSlider.standard(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ],
                        icon: Transform.scale(
                            scaleX: -1,
                            child: const SvgPictureAssetWidget(
                                AppAssetImages.arrowLeftSVGLogoLine,
                                color: Colors.white)),
                        successIcon: const SvgPictureAssetWidget(
                          AppAssetImages.tikSVGLogoSolid,
                          color: Colors.white,
                          height: 34,
                          width: 34,
                        ),
                        foregroundBorderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        backgroundBorderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        sliderBehavior: SliderBehavior.stretch,
                        width: MediaQuery.of(context).size.width * 0.85,
                        backgroundColor: AppColors.primaryColor,
                        toggleColor:
                            AppColors.primaryButtonColor.withOpacity(0.3),
                        action: (slideController) async {
                          slideController.loading(); //starts loading animation
                          await Future.delayed(const Duration(seconds: 2));
                          await controller.acceptRejectRideRequest();
                          if (controller.isSuccess) {
                            await Future.delayed(const Duration(seconds: 1));
                            slideController.success();
                          } else {
                            slideController.failure();
                            controller.otpTextEditingController.clear();
                            slideController.reset();
                          } //starts success animation
                          // controller.reset();
                          log('successfully tapped');
                          await Future.delayed(const Duration(seconds: 1));
                          //Need Update
                          Get.back();
                          Get.offNamed(AppPageNames.startRideRequestScreen,
                              arguments: controller.rideDetails);

                          //resets the slider
                        },
                        child: Text(
                          'Swipe to Start Trip',
                          style: AppTextStyles.semiSmallXBoldTextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  /* <-------- 8px height gap --------> */
                  AppGaps.hGap8,
                ]),
              ),
            ));
  }
}
