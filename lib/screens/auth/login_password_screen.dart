import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/login_password_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class LoginPasswordScreen extends StatelessWidget {
  const LoginPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInPasswordSCreenController>(
        init: LogInPasswordSCreenController(),
        /* <-------- Custom Scaffold for background Scaffold design --------> */
        builder: (controller) => Scaffold(
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Login',
                  hasBackButton: true),
              /* <-------- Body Content  --------> */
              body: Center(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.passwordFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        /* <-------- Phone Number Input Field --------> */
                        controller.isEmail
                            ? CustomTextFormField(
                                // validator: Helper.emailFormValidator,
                                isReadOnly: true,
                                labelText: AppLanguageTranslation
                                    .emailTransKey.toCurrentLanguage,
                                // controller:
                                //     controller.emailTextEditingController,
                                hintText: controller.emailOrPhone,
                                hasShadow: true,
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.emailSVGLogoLine,
                                    color: AppColors.bodyTextColor))
                            : CustomPhoneNumberTextFormFieldWidget(
                                isReadOnly: true,
                                initialCountryCode:
                                    controller.currentCountryCode,
                                hintText: controller.emailOrPhone,
                                // controller:
                                //     controller.phoneTextEditingController,
                                onCountryCodeChanged:
                                    controller.onCountryChange,
                              ),
                        /* <-------- 27px height gap --------> */
                        AppGaps.hGap27,
                        Obx(
                          /* <-------- Password Input Field --------> */
                          () => CustomTextFormField(
                            // validator: Helper.passwordFormValidator,
                            controller:
                                controller.passwordTextEditingController,
                            isPasswordTextField:
                                controller.toggleHidePassword.value,
                            labelText: AppLanguageTranslation
                                .passwordTransKey.toCurrentLanguage,
                            hintText: '********',
                            prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.lockSVGLogoLine,
                              color: AppColors.bodyTextColor,
                            ),
                            suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                color: Colors.transparent,
                                onPressed:
                                    controller.onPasswordSuffixEyeButtonTap,
                                icon: SvgPictureAssetWidget(
                                    controller.toggleHidePassword.value
                                        ? AppAssetImages.hideSVGLogoLine
                                        : AppAssetImages.showSVGLogoLine,
                                    color: controller.toggleHidePassword.value
                                        ? AppColors.bodyTextColor
                                        : AppColors.primaryColor)),
                          ),
                        ),
                        /* <-------- 16px height gap --------> */
                        AppGaps.hGap16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /* <---- Forget password text button ----> */
                            CustomTightTextButtonWidget(
                              onTap: controller.onForgotPasswordButtonTap,
                              /* () {
                            Get.toNamed(AppPageNames.forgotPasswordScreen);
                          }, */
                              child: Text(
                                  AppLanguageTranslation
                                      .forgotPasswordTransKey.toCurrentLanguage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.alertColor)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              /* <------- Bottom Navigation Bar --------> */
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 30 + context.mediaQueryViewInsets.bottom,
                        right: 24,
                        left: 24),
                    /* <-------- Login Button --------> */
                    child: CustomStretchedTextButtonWidget(
                      isLoading: controller.isLoading,
                      buttonText: AppLanguageTranslation
                          .loginTransKey.toCurrentLanguage,
                      onTap: controller.onLoginButtonTap,
                    ),
                  ),
                ],
              ),
            ));
  }
}
