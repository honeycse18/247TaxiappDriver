import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/subscription_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/package_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionScreenController>(
        global: false,
        init: SubscriptionScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: AppColors.backgroundColor,

            /* <-------- Appbar --------> */
            appBar: CoreWidgets.appBarWidget(
                hasBackButton: true,
                screenContext: context,
                titleText: 'Package'),

            /* <-------- Content --------> */

            body: ScaffoldBodyWidget(
                child: RefreshIndicator(
              onRefresh: () async {
                await controller.getSubscriptionList(controller.category);
                controller.update();
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap24,
                  ),
                  controller.subscriptionList.isNotEmpty
                      ? SliverList.separated(
                          itemCount: controller.subscriptionList.length,
                          itemBuilder: (context, index) {
                            final subscriptionItem =
                                controller.subscriptionList[index];

                            return PackageWidget(
                                expireDate: controller
                                    .userDetails.subscriptions.endDate,
                                isPurchased: ((subscriptionItem.id) ==
                                        (controller.userDetails.subscriptions
                                            .subscription.id))
                                    ? true
                                    : false,
                                featuresList: subscriptionItem.features,
                                price: subscriptionItem.price,
                                duration: subscriptionItem.duration,
                                timeText: subscriptionItem.name,
                                onTap: () async {
                                  await Get.toNamed(
                                      AppPageNames.buyPackageScreen,
                                      arguments: subscriptionItem);
                                  await controller.getLoggedInUserDetails();

                                  await controller
                                      .getSubscriptionList(controller.category);
                                  controller.update();
                                });
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap24)
                      : const SliverToBoxAdapter(
                          child: EmptyScreenWidget(
                            localImageAssetURL:
                                AppAssetImages.noSubscriptionImage,
                            title: 'No Subscription Available',
                          ),
                        ),
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap32,
                  ),
                  if (controller.subscriptionHistoryList.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: Text(
                        'Transaction History',
                        style: AppTextStyles.titleSemiboldTextStyle,
                      ),
                    ),
                  if (controller.subscriptionHistoryList.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap16,
                    ),
                  if (controller.subscriptionHistoryList.isNotEmpty)
                    SliverList.separated(
                        itemCount:
                            controller.subscriptionHistoryList.length > 10
                                ? 10
                                : controller.subscriptionHistoryList.length,
                        itemBuilder: (context, index) {
                          final subscriptionHistoryItem =
                              controller.subscriptionHistoryList[index];

                          return SubscriptionHistoryWidget(
                            timeText: Helper.ddMMMyyyyFormattedDate(
                                subscriptionHistoryItem.startDate),
                            duration: subscriptionHistoryItem.duration,
                            price: subscriptionHistoryItem.price,
                            paymentStatus:
                                subscriptionHistoryItem.payment.status,
                            onTap: () {
                              Get.toNamed(AppPageNames.packageDetailsScreen,
                                  arguments: subscriptionHistoryItem);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap24)
                ],
              ),
            ))));
  }
}

class SubscriptionHistoryWidget extends StatelessWidget {
  final String timeText;
  final String paymentStatus;
  final int duration;
  final double price;
  final void Function()? onTap;
  const SubscriptionHistoryWidget({
    super.key,
    required this.timeText,
    required this.duration,
    required this.price,
    this.onTap,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
        padding: EdgeInsets.all(12),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.packageBorderColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      Helper.getCurrencyFormattedWithDecimalAmountText(price),
                      style: AppTextStyles.titleSemiSmallBoldTextStyle,
                    ),
                    Text(
                      ' / $duration Days',
                      style: AppTextStyles.bodyLargeMediumTextStyle,
                    )
                  ]),
                  AppGaps.hGap6,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Payment : ',
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(color: AppColors.packageTextGreyColor),
                      ),
                      Text('${paymentStatus.capitalizeFirst}',
                          style: AppTextStyles.bodySemiboldTextStyle.copyWith(
                            color: paymentStatus == 'paid'
                                ? AppColors.amountColor
                                : paymentStatus == 'pending'
                                    ? AppColors.statusTextColor
                                    : AppColors.errorColor,
                          )),
                    ],
                  ),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Text(
                        'Start Date : ',
                        style: AppTextStyles.bodyMediumTextStyle
                            .copyWith(color: AppColors.packageTextGreyColor),
                      ),
                      Text(
                        timeText,
                        style: AppTextStyles.bodySemiboldTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppGaps.wGap6,
            RawButtonWidget(
              onTap: onTap,
              child: Text(
                'View Details',
                style: AppTextStyles.bodySmallTextStyle.copyWith(
                    wordSpacing: 1.5,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ))
    ]);
  }
}
