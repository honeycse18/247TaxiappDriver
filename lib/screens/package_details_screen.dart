import 'package:flutter/material.dart';
//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:taxiappdriver/controller/package_details_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/package_details_container_widget.dart';

class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageDetailsScreenController>(
        global: false,
        init: PackageDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleText: 'Transaction Details'),

              /* <-------- Content --------> */

              body: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      PackageDetailsContainerWidget(
                          paymentStatus: controller.subscription.payment.status,
                          id: controller.subscription.uid,
                          packagePlan:
                              controller.subscription.subscription.name,
                          packageDuration:
                              controller.subscription.duration.toString(),
                          purchaseDate: Helper.ddMMMyyyyFormattedDate(
                              controller.subscription.startDate),
                          totalPayment:
                              Helper.getCurrencyFormattedWithDecimalAmountText(
                                  controller.subscription.price))
                    ],
                  ),
                ),
              ), /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}
