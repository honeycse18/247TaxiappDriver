import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/change_password_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ChangePasswordPromptScreen extends StatelessWidget {
  const ChangePasswordPromptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordCreateController>(
        init: ChangePasswordCreateController(),
        global: false,
        builder: (controller) => Scaffold(
              /*<------- AppBar ------>*/

              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: 'Change Password',
                hasBackButton: true,
              ),

              /* <-------- Body Content --------> */
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.disabled,
                            key: controller.signUpFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* <---- Current password field----> */
                                Obx(() => CustomTextFormField(
                                      controller: controller
                                          .currentPasswordEditingController,
                                      isPasswordTextField: controller
                                          .toggleHideOldPassword.value,
                                      labelText: AppLanguageTranslation
                                          .oldPasswordTransKey
                                          .toCurrentLanguage,
                                      hintText: '********',
                                      prefixIcon: SvgPicture.asset(
                                          AppAssetImages.lockSVGLogoLine),
                                      suffixIcon: IconButton(
                                          padding: EdgeInsets.zero,
                                          visualDensity: const VisualDensity(
                                              horizontal:
                                                  VisualDensity.minimumDensity,
                                              vertical:
                                                  VisualDensity.minimumDensity),
                                          color: Colors.transparent,
                                          onPressed: () {
                                            controller.toggleHideOldPassword
                                                    .value =
                                                !controller
                                                    .toggleHideOldPassword
                                                    .value;
                                            controller.update();
                                          },
                                          icon: SvgPictureAssetWidget(
                                              controller.toggleHideOldPassword
                                                      .value
                                                  ? AppAssetImages
                                                      .hideSVGLogoLine
                                                  : AppAssetImages
                                                      .showSVGLogoLine,
                                              color: controller
                                                      .toggleHideOldPassword
                                                      .value
                                                  ? AppColors.bodyTextColor
                                                  : AppColors.primaryColor)),
                                    )),
                                /* AppGaps.hGap12,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    /* <---- Forget password text button ----> */
                                    CustomTightTextButtonWidget(
                                      onTap:
                                          controller.onForgotPasswordButtonTap,
                                      /* () {
                                Get.toNamed(AppPageNames.forgotPasswordScreen);
                              }, */
                                      child: Text(
                                          AppLanguageTranslation
                                              .forgotPasswordTransKey
                                              .toCurrentLanguage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: AppColors.alertColor)),
                                    ),
                                  ],
                                ), */
                                AppGaps.hGap24,
                                /* <---- Create new password text field ----> */
                                CustomTextFormField(
                                  validator: Helper.passwordFormValidator,
                                  controller:
                                      controller.newPassword1EditingController,
                                  // hasShadow: false,
                                  isPasswordTextField:
                                      controller.toggleHideNewPassword.value,
                                  labelText: AppLanguageTranslation
                                      .newPasswordTransKey.toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.lockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        controller.toggleHideNewPassword.value =
                                            !controller
                                                .toggleHideNewPassword.value;
                                        controller.update();
                                      },
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHideNewPassword.value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHideNewPassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                ),
                                AppGaps.hGap24,
                                /* <---- Create confirm password text field ----> */
                                CustomTextFormField(
                                  validator:
                                      controller.confirmPasswordFormValidator,
                                  controller:
                                      controller.newPassword2EditingController,
                                  // hasShadow: false,
                                  isPasswordTextField: controller
                                      .toggleHideConfirmPassword.value,
                                  labelText: AppLanguageTranslation
                                      .confirmPasswordTransKey
                                      .toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: SvgPicture.asset(
                                      AppAssetImages.lockSVGLogoLine),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        controller.toggleHideConfirmPassword
                                                .value =
                                            !controller
                                                .toggleHideConfirmPassword
                                                .value;
                                        controller.update();
                                      },
                                      icon: SvgPictureAssetWidget(
                                          controller.toggleHideConfirmPassword
                                                  .value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                                  .value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                ),
                                AppGaps.hGap24,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* <-------- Bottom bar of sign up text --------> */
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                child: CustomStretchedTextButtonWidget(
                    isLoading: controller.isLoading,
                    buttonText: AppLanguageTranslation
                        .savePasswordTransKey.toCurrentLanguage,
                    onTap: controller.onSavePasswordButtonTap
                    // controller.onSavePasswordButtonTap
                    ),
              ),
            ));
  }
}
