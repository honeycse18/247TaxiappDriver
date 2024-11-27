import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class WalletFunction extends StatelessWidget {
  final void Function()? onTap;
  final String localAssetIconName;
  final String title;
  final Color color;
  final double ht;

  const WalletFunction(
      {Key? key,
      required this.title,
      required this.color,
      required this.ht,
      required this.localAssetIconName,
      this.onTap,
      required TextStyle style})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 96,
        color: AppColors.walletIconBackgroundColor,

        /*<----------Withdraw Button in wallet screen--------------->*/
        child: RawButtonWidget(
            borderRadiusValue: 10.0,
            onTap: onTap,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9.0),
                  child: Container(
                    height: 50,
                    width: 126,
                    color: AppColors.walletIconColor,
                    child: Center(
                      child: SvgPictureAssetWidget(
                        localAssetIconName,
                        color: color,
                        height: ht,
                        width: ht,
                      ),
                    ),
                  ),
                ),
                AppGaps.hGap12,
                Center(
                  child: Text(title,
                      style: AppTextStyles.bodySmallMediumTextStyle.copyWith(
                        color: AppColors.infoColor,
                      )),
                ),
              ],
            )));
  }
}
