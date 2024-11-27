import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/login_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
        global: true,
        init: LoginScreenController(),
        /* <-------- Custom Scaffold for background Scaffold design --------> */
        builder: (controller) => Scaffold(
              /* <-------- Side padding for scaffold body contents  --------> */
              body: Center(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      /* <-------- 24px height gap --------> */
                      AppGaps.hGap24,
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                              Center(
                                child: Image.asset(AppAssetImages.logo,
                                    height: 124, width: 187),
                              ),
                              AppGaps.hGap16,
                              /* <---- App name text ----> */
                              const Center(
                                child: Text(
                                  '247Taxiapp',

                                  //   AppLanguageTranslation.appTitleTransKey.toCurrentLanguage,

                                  style: TextStyle(
                                      color: AppColors.primaryTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              /* <-------- 8px height gap --------> */
                              AppGaps.hGap50,
                              Text(
                                'Enter your ${controller.phoneMethod ? 'Phone number' : 'Email Id'} to create an account or login',
                                style: AppTextStyles.bodyLargeTextStyle
                                    .copyWith(color: AppColors.titleTextColor),
                              ),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                              controller.phoneMethod
                                  /* <-------- Phone Number Input Field --------> */
                                  ? CustomPhoneNumberTextFormFieldWidget(
                                      validator: Helper.phoneFormValidator,
                                      initialCountryCode:
                                          controller.currentCountryCode,
                                      controller:
                                          controller.phoneTextEditingController,
                                      hintText: 'Enter Phone Number',
                                      onCountryCodeChanged:
                                          controller.onCountryChange,
                                    )
                                  /* <-------- Email Input Field --------> */
                                  : CustomTextFormField(
                                      validator: Helper.emailFormValidator,
                                      controller:
                                          controller.emailTextEditingController,
                                      labelText: AppLanguageTranslation
                                          .emailTransKey.toCurrentLanguage,
                                      hintText: 'E.g: example@gmail.com',
                                      prefixIcon: SvgPictureAssetWidget(
                                          AppAssetImages.emailSVGLogoLine,
                                          color: AppColors.bodyTextColor)),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,

                              /* <-------- Continue Button --------> */
                              CustomStretchedButtonWidget(
                                isLoading: controller.isLoading,
                                onTap: controller.onContinueButtonTap,
                                child: Text(AppLanguageTranslation
                                    .continueTransKey.toCurrentLanguage),
                              ),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 0.5,
                                      decoration: const BoxDecoration(
                                          color: AppColors.bodyTextColor),
                                    ),
                                  ),
                                  /* <-------- 8px width gap --------> */
                                  AppGaps.wGap8,
                                  Text(
                                    AppLanguageTranslation
                                        .orWithTransKey.toCurrentLanguage,
                                    style: AppTextStyles.bodyMediumTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor),
                                  ),
                                  /* <-------- 8px width gap --------> */
                                  AppGaps.wGap8,
                                  Expanded(
                                    child: Container(
                                      height: 0.5,
                                      decoration: const BoxDecoration(
                                          color: AppColors.bodyTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              /* <-------- 32px height gap --------> */
                              AppGaps.hGap32,
                              controller.phoneMethod
                                  /* <-------- Login with email button --------> */

                                  ? CustomStretchedOutlinedTextButtonWidget(
                                      image: Image.asset(
                                        'assets/images/email.png',
                                        height: 24,
                                        width: 24,
                                      ),
                                      onTap: controller.onMethodButtonTap,
                                      buttonText: AppLanguageTranslation
                                          .continueWithEmailTransKey)
                                  /* <-------- Login with phone number button --------> */
                                  : CustomStretchedOutlinedTextButtonWidget(
                                      image: Image.asset(
                                          'assets/images/Phone.png'),
                                      onTap: controller.onMethodButtonTap,
                                      buttonText: AppLanguageTranslation
                                          .continueWithPhoneTransKey),
                              AppGaps.hGap20,
                              CustomStretchedOutlinedTextButtonWidget(
                                  image: Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                  onTap: controller.onGoogleSignButtonTap,
                                  buttonText: AppLanguageTranslation
                                      .continueWithGoogleTransKey)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }
}
