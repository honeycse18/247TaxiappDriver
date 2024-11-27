import 'package:flutter/cupertino.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/// Single drawer menu widget
class DrawerMenuSvgWidget extends StatelessWidget {
  final String text;
  final String localAssetIconName;
  final Color color;
  final void Function()? onTap;
  const DrawerMenuSvgWidget({
    Key? key,
    required this.text,
    required this.localAssetIconName,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              borderRadiusRadiusValue: Radius.circular(2),
              fixedSize: const Size(40, 40),
              backgroundColor: color.withOpacity(0.1),
              child: SvgPictureAssetWidget(
                localAssetIconName,
                color: color,
                height: 24,
                width: 24,
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.darkColor)),
            ),
          ],
        ));
  }
}

/// Single drawer menu widget
class DrawerMenuPngWidget extends StatelessWidget {
  final String text;
  final String localAssetIconName;
  final Color color;
  final void Function()? onTap;
  const DrawerMenuPngWidget({
    Key? key,
    required this.text,
    required this.localAssetIconName,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              fixedSize: const Size(32, 32),
              backgroundColor: color.withOpacity(0.1),
              child: Image.asset(
                localAssetIconName,
                color: color,
                height: 13,
                width: 13,
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: AppTextStyles.bodyMediumTextStyle
                      .copyWith(color: const Color(0xFF3A416F))),
            ),
          ],
        ));
  }
}
