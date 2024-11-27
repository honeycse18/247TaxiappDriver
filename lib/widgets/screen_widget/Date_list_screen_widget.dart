import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/*<------- Tab list for TabBar widget ------>*/
class TransactionDateStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const TransactionDateStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: RawButtonWidget(
        onTap: onTap,
        borderRadiusValue: 8,
        backgroundColor:
            isSelected ? AppColors.timeTabColor : AppColors.myRideTabColor,
        child: Container(
          height: 34,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.myRideTabColor)),
          child: Text(text,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: isSelected
                  ? AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: AppColors.primaryColor)
                  : AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
        ),
      ),
    );
  }
}
