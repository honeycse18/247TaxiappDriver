import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/withrow_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/select_withdraw_method_widget.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawScreenController>(
        init: WithdrawScreenController(),
        builder: (controller) => Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.withdrawTransKey.toCurrentLanguage,
                  hasBackButton: true),
              /* <-------- Body Content --------> */
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Current Wallet Balance : ',
                          style: AppTextStyles.semiMediumBoldTextStyle
                              .copyWith(color: AppColors.packageTextGreyColor),
                        ),
                        Expanded(
                          child: Text(
                            Helper.getCurrencyFormattedWithDecimalAmountText(
                                controller.balanceAmount),
                            maxLines: 2,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                        ),
                      ],
                    ),
                    AppGaps.hGap20,
                    CustomTextFormField(
                      controller: controller.amountTextEditingController,
                      labelText: 'Withdraw',
                      hintText: 'Enter Withdraw Amount',
                    ),
                    AppGaps.hGap20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .selectMethodTransKey.toCurrentLanguage,
                          style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                        ),
                        RawButtonWidget(
                          onTap: () async {
                            await Get.toNamed(
                                AppPageNames.addWithdrawMethodsScreen);
                            controller.getWithdrawMethod();
                            controller.update();
                          },
                          child: Text(
                            '+ Add Method',
                            style: AppTextStyles.bodyLargeMediumTextStyle
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    AppGaps.hGap20,
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: () async {
                        controller.getWithdrawMethod();
                        controller.update();
                      },
                      child: CustomScrollView(
                        slivers: [
                          controller.withdrawMethod.isNotEmpty
                              ? SliverList.separated(
                                  itemCount: controller.withdrawMethod.length,
                                  itemBuilder: (context, index) {
                                    final withdrawOption =
                                        controller.withdrawMethod[index];
                                    return SelectWithdrawMethodWidget(
                                      paymentOptionImage:
                                          withdrawOption.type.logo,
                                      cancelReason: withdrawOption,
                                      selectedCancelReason: controller
                                          .selectedSavedWithdrawMethod,
                                      paymentOption: withdrawOption.type.name,
                                      hasShadow: controller
                                              .selectedwithdrawMethodIndex ==
                                          index,
                                      onTap: () {
                                        controller.selectedwithdrawMethodIndex =
                                            index;
                                        controller.selectedSavedWithdrawMethod =
                                            withdrawOption;
                                        controller.update();
                                      },
                                      radioOnChange: (Value) {
                                        controller.selectedwithdrawMethodIndex =
                                            index;
                                        controller.selectedSavedWithdrawMethod =
                                            withdrawOption;
                                        controller.update();
                                      },
                                      index: index,
                                      selectedPaymentOptionIndex: controller
                                          .selectedwithdrawMethodIndex,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap16,
                                )
                              : const SliverToBoxAdapter(
                                  child: Center(
                                    child: EmptyScreenWidget(
                                      localImageAssetURL:
                                          AppAssetImages.noSubscriptionImage,
                                      title: 'No Withdraw Method Found',
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    isLoading: controller.isLoading,
                    onTap: (controller.amountTextEditingController.text == '' ||
                            controller.selectedwithdrawMethodIndex == '')
                        ? null
                        : controller.onContinueButtonTap,
                    child: Text(
                      'Withdraw',
                    ),
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}
