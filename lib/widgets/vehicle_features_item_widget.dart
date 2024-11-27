import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';

class VehicleFeaturesWidget extends StatelessWidget {
  final String featuresName;
  final String featuresvalue;
  const VehicleFeaturesWidget({
    super.key,
    required this.featuresName,
    required this.featuresvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          height: 62,
          decoration: const BoxDecoration(
              color: AppColors.lineShapeColor,
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                featuresName,
                style: AppTextStyles.bodyLargeTextStyle
                    .copyWith(color: AppColors.bodyTextColor),
              ),
              Text(featuresvalue, style: AppTextStyles.bodyLargeMediumTextStyle)
            ],
          )),
        ))
      ],
    );
  }
}
