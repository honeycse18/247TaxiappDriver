import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/welcome_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeScreenController>(
      init: WelcomeScreenController(),
      builder: (controller) => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: ScaffoldBodyWidget(
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssetImages.logo,
                        height: 80,
                        width: 80,
                      ),
                      AppGaps.hGap10,
                      Text(
                        '247Taxiapp',
                        style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                            .copyWith(),
                      ),
                      AppGaps.hGap50,
                      const Text(
                        'Enter your phone number to create an account or login',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      AppGaps.hGap15,
                      CustomPhoneNumberTextFormFieldWidget(
                        initialCountryCode: controller.currentCountryCode,
                        controller: controller.phoneTextEditingController,
                        hintText: 'Phone number',
                        onCountryCodeChanged: controller.onCountryChange,
                      ),
                      AppGaps.hGap30,
                      CustomStretchedButtonWidget(
                        onTap: () {
                          Get.toNamed(AppPageNames.zoomDrawerScreen);
                        },
                        child: const Text('Continue'),
                      ),
                      AppGaps.hGap32,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.5,
                              decoration: const BoxDecoration(
                                color: AppColors.bodyTextColor,
                              ),
                            ),
                          ),
                          AppGaps.wGap8,
                          const Text('Or with',
                              style: AppTextStyles.bodyMediumTextStyle),
                          AppGaps.wGap8,
                          Expanded(
                            child: Container(
                              height: 0.5,
                              decoration: const BoxDecoration(
                                color: AppColors.bodyTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap32,
                      //controller.phoneMethod
                      CustomStretchedOutlinedTextButtonWidget(
                        backgroundColor: AppColors.shade1,
                        image: Image.asset('assets/images/message.png'),
                        onTap: () {},
                        buttonText: 'Continue with Email',
                      ),
                      AppGaps.hGap30,
                      CustomStretchedOutlinedTextButtonWidget(
                        backgroundColor: AppColors.shade1,
                        image: Image.asset('assets/images/google.png'),
                        onTap: () {},
                        buttonText: 'Continue with Google',
                      ),
                      AppGaps.hGap10,
                      CustomTightTextButtonWidget(
                          onTap: controller.onForgotPasswordButtonTap,
                          child: Text('Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.alertColor))),
                      AppGaps.hGap10,
                      CustomTightTextButtonWidget(
                          onTap: controller.onProfileButtonTap,
                          child: Text('Profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.primaryColor))),

                      AppGaps.hGap10,
                      CustomTightTextButtonWidget(
                          onTap: controller.onWalletButtonTap,
                          child: Text('Wallet',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.primaryColor))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomScaffoldBottomBarWidget(
              child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Don’t have an account?',
                style: TextStyle(color: AppColors.bodyTextColor),
              ),
              AppGaps.wGap5,
              CustomTightTextButtonWidget(
                onTap: () {
                  Get.toNamed(AppPageNames.signUpScreen);
                },
                child: Text(
                  'Register Now',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
            ],
          ))),
    );
  }
}
