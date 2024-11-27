import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/registration/create_new_password_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateNewPasswordScreenController>(
        init: CreateNewPasswordScreenController(),
        builder: (controller) => Scaffold(
              /* <---- AppBar ----> */
              appBar: CoreWidgets.appBarWidget(
                  titleText: '', screenContext: context, hasBackButton: true),
              /* <---- Body content----> */
              /* <---- Form for creating new password ----> */
              body: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: controller.changePassFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      AppGaps.hGap24,
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* <---- for extra 32px gap in height ----> */
                            AppGaps.hGap24,
                            Text(
                              AppLanguageTranslation
                                  .createNewPasswordTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleBoldTextStyle
                                  .copyWith(color: AppColors.primaryTextColor),
                            ),
                            AppGaps.hGap8,
                            Text(
                              AppLanguageTranslation
                                  .youCanLoginTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyLargeTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            /* <---- for extra 32px gap in height ----> */
                            AppGaps.hGap32,
                            /*<-------Text field for password ------>*/
                            Obx(() => CustomTextFormField(
                                  validator: controller.passwordFormValidator,
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
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          AppAssetImages.hideSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap24,
                            /*<-------Text field for confirm password ------>*/
                            Obx(() => CustomTextFormField(
                                  validator: controller.confirmPasswordFormValidator,
                                  controller: controller
                                      .confirmPasswordTextEditingController,
                                  isPasswordTextField: controller
                                      .toggleHideConfirmPassword.value,
                                  labelText: AppLanguageTranslation
                                      .confirmPasswordTransKey
                                      .toCurrentLanguage,
                                  hintText: '********',
                                  prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.lockSVGLogoLine,
                                    color: AppColors.bodyTextColor,
                                  ),
                                  suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          horizontal:
                                              VisualDensity.minimumDensity,
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      color: Colors.transparent,
                                      onPressed: controller
                                          .onConfirmPasswordSuffixEyeButtonTap,
                                      icon: SvgPictureAssetWidget(
                                          AppAssetImages.hideSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                                  .value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            /* <---- for extra 32px gap in height ----> */
                            AppGaps.hGap32,
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              /*<------- Bottom Bar ------>*/
              bottomNavigationBar: CustomScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedTextButtonWidget(
                       isLoading: controller.isLoading,
                      buttonText: AppLanguageTranslation
                          .savePasswordTransKey.toCurrentLanguage,
                      onTap: controller.onSavePasswordButtonTap,
                    ),
                    AppGaps.hGap24
                  ],
                ),
              ),
            ));
  }
}
