import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/controller/add_withdraw_methods_screen_controller.dart';
import 'package:taxiappdriver/model/api_response/withdraw_method_list_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/widgets/add_withdraw_method_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/select_payment_method_widget.dart';

class AddWithdrawMethodsScreen extends StatelessWidget {
  const AddWithdrawMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWithdrawMethodsScreenController>(
        init: AddWithdrawMethodsScreenController(),
        builder: (controller) => Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Add Withdraw Methods',
                  hasBackButton: true),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.withdrawMethodsPagingController.refresh(),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap20,
                        ),
                        PagedSliverList.separated(
                          pagingController:
                              controller.withdrawMethodsPagingController,
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<WithdrawMethodList>(
                            noItemFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                    isSVGImage: true,
                                    localImageAssetURL:
                                        AppAssetImages.bellFillIcon,
                                    title: 'No withdraw methods yet',
                                    shortTitle: '',
                                  ),
                                ],
                              );
                            },
                            itemBuilder: (context, item, index) {
                              final withdrawMethod = item;
                              return AddWithdrawMethodWidget(
                                paymentOption: withdrawMethod.name,
                                paymentOptionImage: withdrawMethod.logo,
                                hasShadow:
                                    controller.selectedPaymentMethodIndex ==
                                        index,
                                onTap: () async {
                                  controller.selectedPaymentMethodIndex = index;
                                  controller.selectedWithdrawMethod =
                                      withdrawMethod;
                                  await controller.onAddButtonTap(
                                    AddWalletScreenParameter(
                                        neededParams:
                                            withdrawMethod.requiredFields,
                                        type: withdrawMethod.id),
                                  );
                                  controller.update();
                                },
                                radioOnChange: (Value) {
                                  controller.selectedPaymentMethodIndex = index;
                                  controller.selectedWithdrawMethod =
                                      withdrawMethod;
                                  controller.update();
                                },
                                index: index,
                                selectedPaymentOptionIndex:
                                    controller.selectedPaymentMethodIndex,
                              );
                            },
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              /* <-------- 24px height gap --------> */
                              AppGaps.hGap16,
                        ),
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap10,
                        ),
                      ],
                    ),
                  )),
            ));
  }
}
