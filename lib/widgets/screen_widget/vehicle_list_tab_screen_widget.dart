import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ListTabStatusWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  const ListTabStatusWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      borderRadiusValue: 12,
      backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
      child: Container(
        height: 42,
        width: 111,
        alignment: Alignment.center,
        // margin: EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: isSelected
                ? AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: Colors.white)
                : AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: AppColors.primaryTextColor)),
      ),
    );
  }
}
