import 'package:pinput/pinput.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/verification_screen_controller.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationScreenController>(
        init: VerificationScreenController(),
        builder: (controller) => Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: false),
              body: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppGaps.hGap80,
                          AppGaps.hGap20,
                          Row(
                            children: [
                              AppGaps.wGap10,
                              HighlightAndDetailTextWidget(
                                  onTap: () {
                                    /* Get.toNamed(AppPageNames.signUpScreen,
                                        arguments: SignUpScreenParameter(
                                            emailOrPhone: controller.isEmail
                                                ? controller.theData['email']
                                                : controller.theData['phone'],
                                            isEmail: controller.isEmail,
                                            theValue: controller.isEmail
                                                ? controller.theData['email']
                                                : controller.theData['phone'])); */
                                    Get.back();
                                  },
                                  params:
                                      '${controller.isEmail ? controller.theData['email'] : controller.theData['phone']}',
                                  textColor: AppColors.primaryColor,
                                  subtextColor: AppColors.bodyTextColor,
                                  slogan: 'OTP verification',
                                  subtitle:
                                      'An Authentication code has been sent to'),
                            ],
                          ),
                          AppGaps.hGap40,
                          Pinput(
                            controller: controller.otpInputTextController,
                            length: 4,
                            focusedPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: controller.isOtpError
                                  ? const TextStyle(color: Colors.red)
                                  : const TextStyle(
                                      color: AppColors.primaryTextColor),
                              decoration: BoxDecoration(
                                border: controller.isOtpError
                                    ? Border.all(color: Colors.red, width: 1)
                                    : Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                              ),
                            ),
                            submittedPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: controller.isOtpError
                                  ? AppTextStyles.bodyLargeSemiboldTextStyle
                                      .copyWith(color: Colors.red)
                                  : AppTextStyles.bodyLargeSemiboldTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                              decoration: BoxDecoration(
                                color: controller.isOtpError
                                    ? AppColors.alertColor.withOpacity(0.1)
                                    : AppColors.inputColor,
                                border: controller.isOtpError
                                    ? Border.all(color: Colors.red, width: 1)
                                    : Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1),
                              ),
                            ),
                            followingPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: controller.isOtpError
                                  ? const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)
                                  : const TextStyle(
                                      color: AppColors.primaryTextColor,
                                      fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: AppColors.fieldbodyColor,
                                border: Border.all(
                                    color: AppColors.fromBorderColor),
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              width: 80,
                              height: 54,
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                              ),
                            ),
                            onCompleted: (pin) {
                              controller.onSendCodeButtonTap();
                            },
                          ),
                          if (controller.isOtpError)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Invalid Verification Code',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          AppGaps.hGap24,
                          controller.isDurationOver()
                              ? Center(
                                  child: TextButton(
                                      onPressed: controller.isDurationOver()
                                          ? () {
                                              controller.onResendButtonTap();
                                            }
                                          : controller.onResendButtonTap,
                                      child: Text(
                                          AppLanguageTranslation
                                              .resendOTPTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .bodyMediumTextStyle
                                              .copyWith(
                                            color: AppColors.primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                          ))),
                                )
                              : Center(
                                  child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLanguageTranslation
                                          .resendCodeInTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                    AppGaps.wGap10,
                                    Text(
                                        '${controller.otpTimerDuration.inMinutes.toString().padLeft(2, '0')}'
                                        ':${(controller.otpTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                            color: AppColors.primaryColor))
                                  ],
                                )),
                          AppGaps.hGap20,
                          if (controller.shouldShowLoadingIndicator &&
                              controller.isLoading)
                            const SizedBox.square(
                                dimension: 40,
                                child: CircularProgressIndicator()),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ))
                ],
              )),
            ));
  }
}
