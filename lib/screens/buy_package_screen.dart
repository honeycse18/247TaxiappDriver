import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:taxiappdriver/controller/buy_package_screen_controller.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/model/fakeModel/payment_option_model.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/select_payment_method_widget.dart';

class BuyPackageScreen extends StatelessWidget {
  const BuyPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyPackageScreenController>(
      global: false,
      init: BuyPackageScreenController(),
      builder: (controller) => Scaffold(
          backgroundColor: AppColors.backgroundColor,

          /* <-------- Appbar --------> */
          appBar: CoreWidgets.appBarWidget(
              hasBackButton: true,
              screenContext: context,
              titleText: 'Buy Package'),

          /* <-------- Content --------> */

          body: ScaffoldBodyWidget(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap30,
              Container(
                height: 115,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.primary50Color),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.subscription.name,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                ),
                                Image.asset('assets/images/Path.png')
                              ],
                            ),
                            AppGaps.hGap4,
                            Row(
                              children: [
                                Text(
                                  Helper
                                      .getCurrencyFormattedWithDecimalAmountText(
                                          controller.subscription.price),
                                  style:
                                      AppTextStyles.titleSemiSmallBoldTextStyle,
                                ),
                                Text(
                                  ' / ${controller.subscription.duration} Days',
                                  style: AppTextStyles.bodyTextStyle,
                                )
                              ],
                            ),
                            AppGaps.hGap10,
                            SizedBox(
                              height: 35,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final features =
                                        controller.featuresList[index];
                                    return BuySubsScreenWidget(
                                      tittle: features,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.wGap25,
                                  itemCount: controller.featuresList.length),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppGaps.hGap30,
              const Text(
                'Select Method',
                style: AppTextStyles.titleSemiboldTextStyle,
              ),
              AppGaps.hGap16,
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    /* SliverList.separated(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          /// Single payment Option
                          
                          return 
                        },
                        childCount: ,
                      )), */
                    SliverList.separated(
                      itemBuilder: (context, index) {
                        final FakePaymentOptionModel fakePaymentOption =
                            FakeData.subscriptionPaymentOptions[index];
                        return SelectPaymentMethodWidget(
                          paymentOptionImage: fakePaymentOption.paymentImage,
                          cancelReason: fakePaymentOption,
                          selectedCancelReason:
                              controller.selectedPaymentOption,
                          paymentOption: fakePaymentOption.name,
                          hasShadow:
                              controller.selectedPaymentMethodIndex == index,
                          onTap: () {
                            controller.selectedPaymentMethodIndex = index;
                            controller.selectedPaymentOption =
                                fakePaymentOption;
                            controller.update();
                          },
                          radioOnChange: (Value) {
                            controller.selectedPaymentMethodIndex = index;
                            controller.selectedPaymentOption =
                                fakePaymentOption;
                            controller.update();
                          },
                          index: index,
                          selectedPaymentOptionIndex:
                              controller.selectedPaymentMethodIndex,
                        );
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                      itemCount: FakeData.subscriptionPaymentOptions.length,
                    )
                  ],
                ),
              )
            ],
          )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: Container(
              height: 56,
              child: CustomStretchedButtonWidget(
                isLoading: controller.isLoading,
                onTap: controller.buyPackageRequest,
                child: const Text('Process to Pay'),
              ),
            ),
          )),
    );
  }
}

class BuySubsScreenWidget extends StatelessWidget {
  final String tittle;

  const BuySubsScreenWidget({
    required this.tittle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppAssetImages.smallTikSvgLogo),
        AppGaps.wGap5,
        Text(
          tittle,
          style: AppTextStyles.bodySmallMediumTextStyle,
        ),
      ],
    );
  }
}
