import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/help_support_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/settings_screen_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpSupportScreenController>(
      init: HelpSupportScreenController(),
      global: false,
      builder: (controller) => Scaffold(
          appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText:
                AppLanguageTranslation.helpSupportTransKey.toCurrentLanguage,
            hasBackButton: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* <-------- Content --------> */

                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppGaps.hGap16,

                              /* <----privacy policy button ----> */
                              SettingsListTileWidget(
                                titleText: AppLanguageTranslation
                                    .privacyPolicyTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.toNamed(AppPageNames.privacyPolicyScreen);
                                },
                                settingsValueTextWidget: const Text(''),
                              ),
                              AppGaps.hGap16,
                              /* <----terms and condition button ----> */
                              SettingsListTileWidget(
                                titleText: AppLanguageTranslation
                                    .termsConditionTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.toNamed(
                                    AppPageNames.termsConditionScreen,
                                  );
                                  // await Get.toNamed(AppPageNames.languageScreen);
                                  controller.update();
                                },
                                settingsValueTextWidget: const Text(''),
                              ),
                              AppGaps.hGap16,
                              /* <----FAQA button ----> */
                              SettingsListTileWidget(
                                titleText: AppLanguageTranslation
                                    .faqaTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.toNamed(AppPageNames.faqaScreen);
                                  // await Get.toNamed(AppPageNames.languageScreen);
                                  controller.update();
                                },
                                settingsValueTextWidget: const Text(''),
                              ),
                              AppGaps.hGap20,
                              Text('Contact Customer Service',
                                  style: AppTextStyles
                                      .titleSemiSmallSemiboldTextStyle),
                              AppGaps.hGap20,
                              CustomStretchedButtonWidget(
                                onTap: () async {
                                  await launchUrl(Uri.parse(
                                      "https://wa.me/${controller.faqData.whatsapp}"));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/whatsapp.png'),
                                    AppGaps.wGap10,
                                    Text(AppLanguageTranslation
                                        .contactViaWhatsappTransKey
                                        .toCurrentLanguage)
                                  ],
                                ),
                              ),
                              AppGaps.hGap16,
                              CustomStretchedOutlinedButtonWidget(
                                onTap: () async {
                                  await launchUrl(Uri.parse(
                                          'mailto:${controller.faqData.email}')
                                      .replace(queryParameters: {
                                    'subject': 'Need Some Discussion',
                                    'body': 'Text',
                                  }));
                                },
                                bordercolor: AppColors.primaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/Emails.png'),
                                    AppGaps.wGap10,
                                    Text(
                                      AppLanguageTranslation
                                          .contactViaEmailTransKey
                                          .toCurrentLanguage,
                                      style: AppTextStyles
                                          .titleSemiSmallSemiboldTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
