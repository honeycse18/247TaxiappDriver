import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/registration/signup_screen_controller.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/screenParameters/sign_up_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<SignUpScreenController>(
      global: false,
      init: SignUpScreenController(),
      builder: (controller) => Scaffold(
          /* <-------- AppBar --------> */
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText: 'Create an account',
              hasBackButton: true),
          /* <-------- Body Content --------> */
          body: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: controller.signUpFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* <-------- SignUp Form --------> */
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .gettingStartedTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleSemiboldTextStyle,
                            ),
                            AppGaps.hGap8,
                            Text(
                              AppLanguageTranslation
                                  .setUpYourProfileTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyLargeTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap32,
                            /*<-------Text field for full name ------>*/
                            CustomTextFormField(
                                validator: Helper.textFormValidator,
                                controller:
                                    controller.nameTextEditingController,
                                labelText: AppLanguageTranslation
                                    .fullNameTransKey.toCurrentLanguage,
                                hintText: 'E.g jhon doe',
                                prefixIcon: const SvgPictureAssetWidget(
                                  AppAssetImages.profileSVGLogoLine,
                                  color: AppColors.bodyTextColor,
                                )),
                            AppGaps.hGap16,
                            /*<-------Text field for email ------>*/
                            CustomTextFormField(
                                validator: Helper.emailFormValidator,
                                controller:
                                    controller.emailTextEditingController,
                                isReadOnly: controller.screenParameter!.isEmail,
                                labelText: AppLanguageTranslation
                                    .emailAddressTransKey.toCurrentLanguage,
                                hintText: 'E.g abc@example.com',
                                suffixIcon: controller.screenParameter!.isEmail
                                    ? RawButtonWidget(
                                        onTap: () {
                                          Get.toNamed(AppPageNames.loginScreen,
                                              arguments: SignUpScreenParameter(
                                                isEmail: true,
                                                emailOrPhone: controller
                                                    .emailTextEditingController
                                                    .text,
                                              ));
                                        },
                                        child: Text(
                                          'Edit',
                                          maxLines: 1,
                                          style: AppTextStyles.bodyTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.primaryColor),
                                        ),
                                      )
                                    : AppGaps.emptyGap,
                                prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.emailSVGLogoLine)),
                            AppGaps.hGap16,
                            /*<-------Text field for phone number ------>*/
                            PhoneNumberTextFormFieldWidget(
                              validator: Helper.phoneFormValidator,
                              initialCountryCode: controller.currentCountryCode,
                              controller: controller.phoneTextEditingController,
                              isReadOnly: !controller.screenParameter!.isEmail,
                              suffixIcon: !controller.screenParameter!.isEmail
                                  ? RawButtonWidget(
                                      onTap: () {
                                        Get.toNamed(AppPageNames.loginScreen,
                                            arguments: SignUpScreenParameter(
                                                isEmail: false,
                                                emailOrPhone: controller
                                                    .phoneTextEditingController
                                                    .text,
                                                countryCode: controller
                                                    .currentCountryCode));
                                      },
                                      child: Text(
                                        'Edit',
                                        maxLines: 1,
                                        style: AppTextStyles.bodyTextStyle
                                            .copyWith(
                                                color: AppColors.primaryColor),
                                      ),
                                    )
                                  : AppGaps.emptyGap,
                              labelText: 'Phone Number',
                              hintText: '1234567890',
                              onCountryCodeChanged: controller.onCountryChange,
                            ),
                            /*  AppGaps.hGap16,
                              DropdownButtonFormFieldWidget(
                                isRequired: true,
                                hintText: AppLanguageTranslation
                                    .selectCountryTransKey.toCurrentLanguage,
                                labelText: AppLanguageTranslation
                                    .selectCountryTransKey.toCurrentLanguage,
                                value: controller.selectedCountry,
                                items: controller.countryList,
                                isDense: false,
                                // getItemText: (p0) => p0.name,
                                getItemChild: controller.countryElementsList,
                                onChanged: (selectedItem) {
                                  controller.selectedCountry =
                                      selectedItem ?? UserDetailsCountry();

                                  controller.update();
                                },
                              ), */
                            AppGaps.hGap5,
                            /* DropdownButtonFormFieldWidget<String>(
                                hintText: 'Gender',
                                value: controller.selectedGender,
                                items: ['male', 'female', 'other'],
                                getItemText: (gender) =>
                                    gender.capitalizeFirst!,
                                onChanged: (value) {
                                  controller.selectedGender = value;
                                  controller.update();
                                },
                                validator: (value) => value == null
                                    ? 'Please select a gender'
                                    : null,
                              ), */
                            DropdownButtonFormFieldWidget(
                              validator: (value) => value == null
                                  ? 'Please select a gender'
                                  : null,
                              labelText: 'Gender',
                              hintText: 'e.g. Male',
                              value: controller.selectedGender,
                              items: const ['male', 'female', 'other'],
                              getItemTextIndex: (i, p0) =>
                                  '${p0.capitalizeFirst}',
                              onChanged: (selectedItem) {
                                controller.selectedGender = selectedItem;
                                controller.update();
                              },
                            ),
                            AppGaps.hGap16,

                            /*<-------Text field for password ------>*/
                            Obx(() => CustomPasswordTextFormField(
                                  focusNode: controller.passwordFocusNode,
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
                                          controller.toggleHidePassword.value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHidePassword.value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            AppGaps.hGap16,
                            /*<-------Text field for confirm password ------>*/
                            Obx(() => CustomPasswordTextFormField(
                                  focusNode:
                                      controller.confirmPasswordFocusNode,
                                  validator:
                                      controller.confirmPasswordFormValidator,
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
                                          controller.toggleHideConfirmPassword
                                                  .value
                                              ? AppAssetImages.hideSVGLogoLine
                                              : AppAssetImages.showSVGLogoLine,
                                          color: controller
                                                  .toggleHideConfirmPassword
                                                  .value
                                              ? AppColors.bodyTextColor
                                              : AppColors.primaryColor)),
                                )),
                            /* AppGaps.hGap16,
                              CustomTextFormField(
                                  validator: Helper.textFormValidator,
                                  controller:
                                      controller.nameTextEditingController,
                                  labelText: 'Refer code (Optional)',
                                  hintText: 'Ex: 50420',
                                  prefixIcon: const SvgPictureAssetWidget(
                                    AppAssetImages.referSVGLogoLine,
                                    color: AppColors.bodyTextColor,
                                  )), */
                            AppGaps.hGap16,
                            /*<------- checkbox for terms and conditions ------>*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: screenSize.width < 458
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Obx(() => Checkbox(
                                      value: controller
                                          .toggleAgreeTermsConditions.value,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      onChanged: controller
                                          .onToggleAgreeTermsConditions)),
                                ),
                                AppGaps.wGap16,
                                /*<------- By creating an account, you agree to our terms and conditions ------>*/
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.onToggleAgreeTermsConditions(
                                            !controller
                                                .toggleAgreeTermsConditions
                                                .value),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          AppLanguageTranslation
                                              .createingAccountYouAgreeTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles.bodyTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                        CustomTightTextButtonWidget(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .termsConditionScreen);
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .termsConditionTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodySmallMediumTextStyle
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .primaryColor),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            /* <---- for extra 32px gap in height ----> */
                            AppGaps.hGap32,
                            /*<------- Continue button ------>*/
                            CustomStretchedTextButtonWidget(
                              isLoading: controller.isLoading,
                              buttonText: 'Create An Account',
                              onTap: controller.toggleAgreeTermsConditions.value
                                  ? controller.onContinueButtonTap
                                  : null,
                            ),
                            AppGaps.hGap32,
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
