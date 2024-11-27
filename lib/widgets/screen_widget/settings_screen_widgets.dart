import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class SettingsListTileWidget extends StatelessWidget {
  final Widget settingsValueTextWidget;
  final String titleText;
  final Widget? valueWidget;
  final void Function()? onTap;
  final bool showRightArrow;

  const SettingsListTileWidget({
    Key? key,
    required this.titleText,
    this.valueWidget,
    this.onTap,
    this.showRightArrow = true,
    required this.settingsValueTextWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      onTap: onTap,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  settingsValueTextWidget,
                  const SvgPictureAssetWidget(
                    AppAssetImages.rightSingleArrowSVGLogoLine,
                    color: Color(0xFF8294AE),
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
            valueWidget ?? AppGaps.emptyGap,
            showRightArrow ? AppGaps.wGap8 : AppGaps.emptyGap,
          ],
        ),
      ),
    );
  }
}

class CommonListTileWidget extends StatelessWidget {
  final Widget settingsValueTextWidget;
  final String titleText;
  final Widget? valueWidget;
  final void Function()? onTap;
  final bool showRightArrow;

  const CommonListTileWidget({
    Key? key,
    required this.titleText,
    this.valueWidget,
    this.onTap,
    this.showRightArrow = true,
    required this.settingsValueTextWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                settingsValueTextWidget,
                const SvgPictureAssetWidget(
                  AppAssetImages.rightArrowSVGLogoLine,
                  color: AppColors.bodyTextColor,
                  height: 15,
                  width: 15,
                ),
              ],
            ),
          ),
          valueWidget ?? AppGaps.emptyGap,
          showRightArrow ? AppGaps.wGap8 : AppGaps.emptyGap,
        ],
      ),
    );
  }
}
