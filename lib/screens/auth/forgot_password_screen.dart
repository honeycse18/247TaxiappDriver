import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/forgot_password_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordSCreenController>(
        init: ForgotPasswordSCreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  appBarBackgroundColor: AppColors.backgroundColor,
                  screenContext: context,
                  titleText: 'Forget Password',
                  hasBackButton: true),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap10,
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text(
                          'Forgot Password',
                          style: AppTextStyles.titleBoldTextStyle,
                        ),
                        AppGaps.hGap8,
                        Text(
                          'Select which contact details should we use to reset your password',
                          style: AppTextStyles.bodyLargeTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                      ])),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap30,
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: AppColors.shade1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: controller.forgotPasswordTabWidget(
                              isSelected: controller.isSendCodeOptionSelected,
                              title: 'Email',
                              onTap: () {
                                if (!controller.isSendCodeOptionSelected) {
                                  controller.isSendCodeOptionSelected =
                                      !controller.isSendCodeOptionSelected;
                                  controller.update();
                                }
                              },
                            )),
                            Expanded(
                              child: controller.forgotPasswordTabWidget(
                                isSelected:
                                    !controller.isSendCodeOptionSelected,
                                title: 'Phone',
                                onTap: () {
                                  if (controller.isSendCodeOptionSelected) {
                                    controller.isSendCodeOptionSelected =
                                        !controller.isSendCodeOptionSelected;
                                    controller.update();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap30,
                  ),
                  SliverToBoxAdapter(
                    child: !controller.isSendCodeOptionSelected
                        ? CustomPhoneNumberTextFormFieldWidget(
                            initialCountryCode: controller.currentCountryCode,
                            controller: controller.phoneTextEditingController,
                            hintText: 'Phone number',
                            onCountryCodeChanged: controller.onCountryChange,
                          )
                        : CustomTextFormField(
                            validator: Helper.emailFormValidator,
                            controller: controller.emailTextEditingController,
                            labelText: 'Email',
                            hintText: 'eg: abc@example.com',
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.emailSVGLogoLine)),
                  )
                ],
              )),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomStretchedTextButtonWidget(
                    buttonText: 'Send Verification Code',
                    onTap: () {
                      Get.toNamed(AppPageNames.createNewPasswordScreen);
                    },
                  )
                ],
              )),
            ));
  }
}
