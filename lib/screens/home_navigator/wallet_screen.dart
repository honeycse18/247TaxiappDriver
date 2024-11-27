import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/controller/wallet_screen_controller.dart';
import 'package:taxiappdriver/model/api_response/wallet_history_response.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/Date_list_screen_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/transaction_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/wallet_function_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<WalletScreenController>(
        init: WalletScreenController(),
        global: false,
        builder: (controller) => Container(
              color: AppColors.walletContainerColor,
              child: Scaffold(
                extendBody: true,
                // appBar: AppBar(
                //   title: Text(
                //     AppLanguageTranslation.myWalletTransKey.toCurrentLanguage,
                //     style: AppTextStyles.bodyLargeBoldTextStyle
                //         .copyWith(color: AppColors.infoColor),
                //   ),
                // ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    controller.transactionHistoryPagingController.refresh();
                    controller.getWalletDetails();
                    controller.update();
                  },
                  child: Container(
                    height: screenHeight,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                    ),
                    child: Stack(children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          width: screenWidth,
                          height: 400,
                          color: AppColors.walletContainerColor,
                          child: Center(
                              child: Column(
                            children: [
                              AppGaps.hGap130,
                              Text(
                                  AppLanguageTranslation
                                      .yourBalanceTransKey.toCurrentLanguage,
                                  style: AppTextStyles.semiMediumBoldTextStyle
                                      .copyWith(color: AppColors.infoColor)),
                              AppGaps.hGap24,
                              ScaffoldBodyWidget(
                                child: Text(
                                    Helper
                                        .getCurrencyFormattedWithDecimalAmountText(
                                            controller.walletDetails.balance),
                                    style: AppTextStyles
                                        .titleExtraLargeBoldTextStyle
                                        .copyWith(color: AppColors.infoColor)),
                              ),
                            ],
                          )),
                        ),
                      ),
                      Positioned.fill(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 150, left: 24, right: 24),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: screenWidth,
                                    child: Column(
                                      children: [
                                        AppGaps.hGap135,
                                        Row(children: [
                                          Expanded(
                                            child: WalletFunction(
                                              onTap: () async {
                                                await Get.toNamed(
                                                    AppPageNames.topUpScreen);
                                                await controller
                                                    .getWalletDetails();
                                              },
                                              title: AppLanguageTranslation
                                                  .topUpTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodySmallBoldTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.infoColor),
                                              localAssetIconName: AppAssetImages
                                                  .topUpSVGLogoSolid,
                                              ht: 24.00,
                                              color: AppColors.topUpIconColor,
                                            ),
                                          ),
                                          AppGaps.wGap24,
                                          Expanded(
                                            child: WalletFunction(
                                              onTap: () {
                                                /* showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return WithdrawDialogWidget();
                                                  },
                                                ); */
                                                Get.toNamed(
                                                    AppPageNames.withdrawScreen,
                                                    arguments: controller
                                                        .walletDetails.balance);
                                              },
                                              title: AppLanguageTranslation
                                                  .withdrawTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodySmallBoldTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.infoColor),
                                              localAssetIconName: AppAssetImages
                                                  .withdrawSVGLogoSolid,
                                              ht: 24.00,
                                              color:
                                                  AppColors.withdrawIconColor,
                                            ),
                                          ),

                                          /* WalletFunction(
                                                onTap: () {},
                                                title: AppLanguageTranslation
                                                    .payForOtherTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .bodySmallBoldTextStyle
                                                    .copyWith(
                                                        color:
                                                            AppColors.infoColor),
                                                localAssetIconName: AppAssetImages
                                                    .payForOtherSVGLogoSolid,
                                                ht: 24.00,
                                                color: AppColors.primaryColor,
                                              ), */
                                        ]),
                                        AppGaps.hGap40,
                                        /*<-----------Transaction status and Wallet balance------>*/
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              AppLanguageTranslation
                                                  .historyTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .titleBoldTextStyle),
                                        ),
                                        AppGaps.hGap12,
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .all.stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .all,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .all);
                                                  },
                                                ),
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .today.stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .today,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .today);
                                                  },
                                                ),
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .thisWeek
                                                      .stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .thisWeek,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .thisWeek);
                                                  },
                                                ),
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .thisMonth
                                                      .stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .thisMonth,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .thisMonth);
                                                  },
                                                ),
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .thisYear
                                                      .stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .thisYear,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .thisYear);
                                                  },
                                                ),
                                                TransactionDateStatusWidget(
                                                  text: TransactionHistoryStatus
                                                      .withdrawHistory
                                                      .stringValueForView,
                                                  isSelected: controller
                                                          .selectedStatus
                                                          .value ==
                                                      TransactionHistoryStatus
                                                          .withdrawHistory,
                                                  onTap: () {
                                                    controller.onRideTabTap(
                                                        TransactionHistoryStatus
                                                            .withdrawHistory);
                                                  },
                                                ),
                                              ],
                                            )),
                                        AppGaps.hGap10,
                                        Expanded(
                                            child: CustomScrollView(
                                          slivers: [
                                            controller.selectedStatus !=
                                                    TransactionHistoryStatus
                                                        .withdrawHistory
                                                ? PagedSliverList.separated(
                                                    pagingController: controller
                                                        .transactionHistoryPagingController,
                                                    builderDelegate:
                                                        PagedChildBuilderDelegate<
                                                                TransactionHistoryItems>(
                                                            noItemsFoundIndicatorBuilder:
                                                                (context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          /* <---- Empty transaction history ----> */
                                                          EmptyScreenWidget(
                                                            height: 100,
                                                            localImageAssetURL:
                                                                AppAssetImages
                                                                    .emptyWalletIconImage,
                                                            title: AppLanguageTranslation
                                                                .noTransactionTransKey
                                                                .toCurrentLanguage,
                                                            shortTitle: AppLanguageTranslation
                                                                .youHaveNoTransactionYetTransKey
                                                                .toCurrentLanguage,
                                                          )
                                                        ],
                                                      );
                                                    }, itemBuilder: (context,
                                                                item, index) {
                                                      final TransactionHistoryItems
                                                          transactionHistoryList =
                                                          item;
                                                      /*<------transaction message----->*/
                                                      return TransactionWidget(
                                                        type: 'add_money',
                                                        title: Helper.formatTitle(
                                                            transactionHistoryList
                                                                .type),
                                                        dayText: Helper
                                                            .ddMMMyyyyhhmmFormattedDateTime(
                                                                transactionHistoryList
                                                                    .createdAt),
                                                        amountText: Helper
                                                            .getCurrencyFormattedWithDecimalAmountText(
                                                                transactionHistoryList
                                                                    .amount),
                                                        color: AppColors
                                                            .topUpIconColor,
                                                        backColor: AppColors
                                                            .timeTabColor,
                                                      );
                                                    }),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            AppGaps.hGap16,
                                                  )
                                                : PagedSliverList.separated(
                                                    pagingController: controller
                                                        .transactionHistoryPagingController,
                                                    builderDelegate:
                                                        PagedChildBuilderDelegate<
                                                                TransactionHistoryItems>(
                                                            noItemsFoundIndicatorBuilder:
                                                                (context) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          /* <---- Empty transaction history ----> */
                                                          EmptyScreenWidget(
                                                            height: 100,
                                                            localImageAssetURL:
                                                                AppAssetImages
                                                                    .emptyWalletIconImage,
                                                            title: AppLanguageTranslation
                                                                .noTransactionTransKey
                                                                .toCurrentLanguage,
                                                            shortTitle: AppLanguageTranslation
                                                                .youHaveNoTransactionYetTransKey
                                                                .toCurrentLanguage,
                                                          )
                                                        ],
                                                      );
                                                    }, itemBuilder: (context,
                                                                item, index) {
                                                      final TransactionHistoryItems
                                                          transactionHistoryList =
                                                          item;
                                                      /*<------transaction message----->*/
                                                      return TransactionWidget(
                                                        type: 'withdraw',
                                                        title:
                                                            '${Helper.formatTitle(transactionHistoryList.withdrawMethod.name)}  Withdraw ',
                                                        dayText: Helper
                                                            .ddMMMyyyyhhmmFormattedDateTime(
                                                                transactionHistoryList
                                                                    .updatedAt),
                                                        amountText: Helper
                                                            .getCurrencyFormattedWithDecimalAmountText(
                                                                transactionHistoryList
                                                                    .amount),
                                                        color: transactionHistoryList
                                                                    .status !=
                                                                'pending'
                                                            ? AppColors
                                                                .topUpIconColor
                                                            : AppColors
                                                                .withdrawIconColor,
                                                        backColor: AppColors
                                                            .timeTabColor,
                                                      );
                                                    }),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            AppGaps.hGap16,
                                                  ),
                                            SliverToBoxAdapter(
                                              child: AppGaps.hGap100,
                                            )
                                          ],
                                        )),
                                        AppGaps.hGap10,
                                      ],
                                    ),
                                  )))),
                    ]),
                  ),
                ),
              ),
            ));
  }
}
