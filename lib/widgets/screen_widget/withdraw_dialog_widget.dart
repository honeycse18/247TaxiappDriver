import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taxiappdriver/controller/withdraw_dialouge_screen_dialouge_controller.dart';
import 'package:taxiappdriver/model/api_response/get_withdraw_saved_methods.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class WithdrawDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  // final String buttonText;

  WithdrawDialogWidget({
    this.title = '',
    this.description = '',
    // required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawDialogWidgetScreenController>(
        global: false,
        init: WithdrawDialogWidgetScreenController(),
        builder: (controller) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 425,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                    Radius.circular(AppConstants.defaultBorderRadiusValue)),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.withdrawKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            validator: Helper.withdrawValidator,
                            controller: controller.amountController,
                            labelText: "Enter Amount",
                            hintText: 'Enter Amount',
                            textInputType: TextInputType.number,
                          ),
                          AppGaps.hGap16,
                          controller.withdrawMethod.isEmpty
                              ? CustomTextFormField(
                                  isReadOnly: true,
                                  controller: controller.amountController,
                                  labelText: 'Select withdraw method',
                                  hintText: 'No withdraw method found',
                                  textInputType: TextInputType.number,
                                )
                              : Obx(() => DropdownButtonFieldWidget<
                                      SavedWithdrawMethods>(
                                    labelText: 'Select withdraw method',
                                    labelTextColor: AppColors.primaryTextColor,
                                    hintText: 'Select withdraw method',
                                    items: controller.withdrawMethod,
                                    isLoading:
                                        controller.isElementsLoading.value,
                                    value:
                                        controller.selectedSavedWithdrawMethod,
                                    getItemText: (item) => item.type.name,
                                    onChanged: controller.onMethodChanged,
                                  )),
                          AppGaps.hGap4,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RawButtonWidget(
                                onTap: () async {
                                  await Get.toNamed(
                                      AppPageNames.addWithdrawMethodsScreen);
                                  controller.getWithdrawMethod();
                                  controller.update();
                                },
                                child: Text(
                                  '+ Add Method',
                                  style: AppTextStyles.bodyMediumTextStyle
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap16,
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomStretchedTextButtonWidget(
                                isLoading: controller.isLoading,
                                buttonText: AppLanguageTranslation
                                    .withdrawTransKey.toCurrentLanguage,
                                // backgroundColor: AppColors.alertColor,
                                onTap: controller.onContinueButtonTap,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
