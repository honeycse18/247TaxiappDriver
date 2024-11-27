import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';

class TransactonHistoryContainerWidget extends StatelessWidget {
  final String id;
  final String packagePlan;
  final String paymentDate;
  final String paymentMethod;
  final String paymentStatus;
  final String totalPayment;
  const TransactonHistoryContainerWidget(
      {super.key,
      required this.id,
      required this.packagePlan,
      required this.paymentDate,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.totalPayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 253,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.hGap10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Id: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    id,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Package Plan: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    packagePlan,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Date: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    paymentDate,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Method: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    paymentMethod,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Status: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    paymentStatus,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.amountColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Divider(),
              AppGaps.hGap10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    totalPayment,
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.amountColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
