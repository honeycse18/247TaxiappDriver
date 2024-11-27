import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/topup_screen_controller.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/select_payment_method_widget.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpScreenController>(
      init: TopUpScreenController(),
      builder: (controller) => Scaffold(
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleText: AppLanguageTranslation.topUpTransKey.toCurrentLanguage,
            hasBackButton: true),
        /* <-------- Body Content --------> */
        body: ScaffoldBodyWidget(
            child: CustomScrollView(
          slivers: [
            /* <---- for extra 20px gap in height ----> */

            const SliverToBoxAdapter(child: AppGaps.hGap8),
            /* <---- Top Up amount text field----> */
            SliverToBoxAdapter(
              child: CustomTextFormField(
                controller: controller.topUpAmount,
                labelText: AppLanguageTranslation
                    .topUpAmountTransKey.toCurrentLanguage,
                hintText: 'Top Up Amount',
                textInputType: TextInputType.number,
              ),
            ),
            const SliverToBoxAdapter(child: AppGaps.hGap14),
            SliverToBoxAdapter(
              child: Text(
                AppLanguageTranslation
                    .selectTopUpMethodTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
              ),
            ),
            const SliverToBoxAdapter(child: AppGaps.hGap20),

            /* <---- Payment Method----> */
            SliverList.separated(
              itemCount: FakeData.topupOptionList.length,
              itemBuilder: (context, index) {
                final paymentOption =
                    FakeData.subscriptionPaymentOptions[index];
                return SelectPaymentMethodWidget(
                  paymentOptionImage: paymentOption.paymentImage,
                  cancelReason: paymentOption,
                  selectedCancelReason: controller.selectedPaymentOption,
                  paymentOption: paymentOption.name,
                  hasShadow: controller.selectedPaymentMethodIndex == index,
                  onTap: () {
                    controller.selectedPaymentMethodIndex = index;
                    controller.selectedPaymentOption = paymentOption;
                    // controller.update();
                  },
                  radioOnChange: (Value) {
                    controller.selectedPaymentMethodIndex = index;
                    controller.selectedPaymentOption = paymentOption;
                    // controller.update();
                  },
                  index: index,
                  selectedPaymentOptionIndex:
                      controller.selectedPaymentMethodIndex,
                );
              },
              separatorBuilder: (context, index) => AppGaps.hGap16,
            ),
            const SliverToBoxAdapter(child: AppGaps.hGap10),
          ],
        )),
        bottomNavigationBar: ScaffoldBodyWidget(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomStretchedButtonWidget(
              isLoading: controller.isLoading,
              onTap: controller.shouldEnableTopupButton
                  ? controller.topUpWallet
                  : null,
              child: Text(
                AppLanguageTranslation.topUpTransKey.toCurrentLanguage,
              ),
            ),
            AppGaps.hGap20,
          ],
        )),
      ),
    );
  }
}
