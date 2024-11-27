import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';

class PackageDetailsContainerWidget extends StatelessWidget {
  final String id;
  final String packagePlan;
  final String packageDuration;
  final String purchaseDate;
  final String paymentStatus;
  final String totalPayment;
  const PackageDetailsContainerWidget(
      {super.key,
      required this.id,
      required this.packagePlan,
      required this.packageDuration,
      required this.purchaseDate,
      required this.totalPayment,
      required this.paymentStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 261,
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
                    style: AppTextStyles.bodyBoldTextStyle
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
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Package Duration: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    '${packageDuration} / days',
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Date: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text(
                    purchaseDate,
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                ],
              ),
              AppGaps.hGap15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Payment Status: ',
                    style: AppTextStyles.bodyMediumTextStyle
                        .copyWith(color: AppColors.packageTextGreyColor),
                  ),
                  Text('${paymentStatus.capitalizeFirst}',
                      style: AppTextStyles.bodyBoldTextStyle.copyWith(
                        color: paymentStatus == 'paid'
                            ? AppColors.amountColor
                            : paymentStatus == 'pending'
                                ? AppColors.statusTextColor
                                : AppColors.errorColor,
                      )),
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
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.packageTextBoldColor),
                  ),
                  Text(
                    totalPayment,
                    style: AppTextStyles.bodyLargeBoldTextStyle
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
