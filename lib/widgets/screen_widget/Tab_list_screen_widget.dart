import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/*<------- Tab list for TabBar widget ------>*/
class TabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const TabStatusWidget(
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
          height: 46,
          width: 117,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.myRideTabColor,
            ),
          ),
          child: Text(text,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: isSelected
                  ? AppTextStyles.bodyLargeTextStyle
                      .copyWith(color: AppColors.primaryColor)
                  : AppTextStyles.bodyLargeTextStyle
                      .copyWith(color: AppColors.primaryTextColor)),
        ),
      ),
    );
  }
}
