import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:taxiappdriver/controller/about_us_controller.dart';
import 'package:taxiappdriver/controller/transaction_history_screen.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/transacton_history_container_widget.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryScreenController>(
        global: false,
        init: TransactionHistoryScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleText: 'Transaction History'),

              /* <-------- Content --------> */

              body: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      Row(
                        children: [
                          Expanded(
                              child: TransactonHistoryContainerWidget(
                            id: 'M-L7h9pd7s',
                            packagePlan: 'Weekly',
                            paymentDate: '12 Apr 2024',
                            paymentMethod: 'PayPal',
                            paymentStatus: 'Paid',
                            totalPayment: '500 SAR',
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ), /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}
