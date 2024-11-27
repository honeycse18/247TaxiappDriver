//transaction widget
import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class DocumentsFieldWidget extends StatelessWidget {
  final String title;
  final String hintText1;
  final String hintText;
  final Widget rightIcon;
  final bool isRequired;
  final bool isFound;
  final bool isGet;
  final void Function()? onTap;
  final void Function()? onViewTap;
  final void Function()? onClickTap;
  final FocusNode? focusNode;
  const DocumentsFieldWidget({
    Key? key,
    required this.title,
    this.hintText1 = '',
    required this.hintText,
    required this.rightIcon,
    this.onTap,
    this.onClickTap,
    this.onViewTap,
    required this.isRequired,
    this.isFound = false,
    this.isGet = false,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppTextStyles.labelTextStyle,
            ),
            if (title != '' && isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySmallSemiboldTextStyle
                    .copyWith(color: AppColors.errorColor),
              )
          ],
        ),
        AppGaps.hGap10,
        RawButtonWidget(
          onTap: onTap,
          focusNode: focusNode,
          child: Container(
            height: 50,
            decoration: const BoxDecoration(
                color: AppColors.fieldbodyColor,
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/capture.png'),
                  isFound
                      ? Text(
                          hintText1,
                        )
                      : Text(hintText),
                  AppGaps.wGap10,
                  rightIcon,
                  AppGaps.wGap5,
                ],
              ),
            ),
          ),
        ),
        AppGaps.hGap8,
        if (isGet)
          RawButtonWidget(
            onTap: onClickTap,
            child: Text(
              'Click To View',
              style: AppTextStyles.bodySmallTextStyle.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppColors.primaryColor),
            ),
          )
      ],
    );
  }
}
