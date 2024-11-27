import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class AppDialogs {
  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    /*<------- Vibrate the phone ------>*/
    // final hasVibrator = await Vibration.hasVibrator();

    /*<------- Check if hasVibrator is not null and is true ------>*/
    // if (hasVibrator == true) {
    //   /*<------- Vibrate for 500 milliseconds ------>*/
    //   Vibration.vibrate(duration: 500);
    // }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.errorImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            onTap: () {
              Get.back();
            },
            child: const Text(
              'Ok',
            ))
      ],
    ));
  }

  /*<------- Confirm dialog ------>*/
  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(AppAssetImages.confirmImage),
            AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Text(
          messageText,
          style: AppTextStyles.bodyLargeSemiboldTextStyle,
          textAlign: TextAlign.center,
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped &&
                        (Get.isDialogOpen ?? false)) {
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<Object?> showProcessingDialog({String? message}) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              message ??
                  AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<Object?> showSuccessDialog(
      {String? titleText,
      required String messageText,
      bool isCancellable = true}) async {
    final String dialogTitle = titleText ?? 'Success';
    return await Get.dialog(
        AlertDialogWidget(
          backgroundColor: Colors.white,
          titleWidget: Column(
            children: [
              Image.asset(AppAssetImages.success),
              AppGaps.hGap30,
              Text(dialogTitle,
                  style: AppTextStyles.titleSmallSemiboldTextStyle
                      .copyWith(color: AppColors.darkColor),
                  textAlign: TextAlign.center),
            ],
          ),
          contentWidget: Text(messageText,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
              textAlign: TextAlign.center),
          actionWidgets: [
            CustomStretchedTextButtonWidget(
              buttonText: 'Done',
              onTap: () {
                Get.back(result: true);
              },
            )
          ],
        ),
        barrierDismissible: isCancellable);
  }

  static Future<Object?> showAcceptLocationDialog({
    String titleText = 'Enable your location',
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String yesButtonText = 'Allow',
    String noButtonText = 'Skip for now',
  }) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.enableLocationIconImage),
          AppGaps.hGap16,
          Text(titleText,
              style: AppTextStyles.titleLargeBoldTextStyle
                  .copyWith(color: AppColors.darkColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          style: AppTextStyles.bodyLargeSemiboldTextStyle
              .copyWith(color: AppColors.bodyTextColor),
          textAlign: TextAlign.center),
      actionWidgets: [
        Column(
          children: [
            CustomStretchedTextButtonWidget(
              buttonText: yesButtonText,
              onTap: () async {
                await onYesTap();
                if (shouldCloseDialogOnceYesTapped) Get.back();
              },
            ),
            AppGaps.hGap10,
            CustomStretchedOnlyTextButtonWidget(
              buttonText: noButtonText,
              onTap: onNoTap ??
                  () {
                    Get.back();
                  },
            ),
          ],
        )
      ],
    ));
  }

  static Future<Object?> showRideAcceptDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesAcceptTap,
    void Function()? onNotNowTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: const Column(
          children: [
            AppGaps.hGap16,
            Text('You want to accept this',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Text(
          messageText,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.hintTextColor),
          textAlign: TextAlign.center,
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: RawButtonWidget(
                  onTap: onNotNowTap ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    height: 60,
                    width: 153,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.primaryColor)),
                    child: const Center(
                        child: Text(
                      'Not Now',
                      style: TextStyle(color: AppColors.primaryColor),
                    )),
                  ),
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: 'Yes, Accept',
                  onTap: () async {
                    await onYesAcceptTap();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
