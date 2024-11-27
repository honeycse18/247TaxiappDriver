import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class PackageWidget extends StatelessWidget {
  final String timeText;
  final int duration;
  final double price;
  final bool isPurchased;
  final bool isLoading;
  final DateTime expireDate;
  final List<String> featuresList;
  final void Function()? onTap;
  const PackageWidget({
    super.key,
    required this.timeText,
    required this.duration,
    required this.price,
    this.isLoading = false,
    required this.featuresList,
    required this.isPurchased,
    required this.onTap,
    required this.expireDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: AppColors.packageBorderColor, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            timeText,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                          AppGaps.hGap4,
                          Row(
                            children: [
                              Text(
                                Helper
                                    .getCurrencyFormattedWithDecimalAmountText(
                                        price),
                                style:
                                    AppTextStyles.titleSemiSmallBoldTextStyle,
                              ),
                              Text(
                                ' / $duration Days',
                                style: AppTextStyles.bodyTextStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/blurCar.png',
                        height: 90,
                        width: 138,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                  AppGaps.hGap10,
                  SizedBox(
                    height: 35,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final features = featuresList[index];
                          return FeaturesWidget(
                            title: features,
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.wGap25,
                        itemCount: featuresList.length),
                  ),
                  const Divider(),
                  AppGaps.hGap10,
                  isPurchased
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 54,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 1, color: Color(0xFF248DD3)),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Active',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: AppColors.successColor,
                                        fontSize: 16,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    AppGaps.hGap4,
                                    Text(
                                      'Expire - ${Helper.ddMMMyyyyFormattedDateTime(expireDate)}',
                                      style: const TextStyle(
                                        color: Color(0xFFFF392D),
                                        fontSize: 12,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 44,
                            child: CustomStretchedButtonWidget(
                              isLoading: isLoading,
                              onTap: onTap,
                              child: Text(
                                  'Buy Now - ${Helper.getCurrencyFormattedWithDecimalAmountText(price)}'),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FeaturesWidget extends StatelessWidget {
  final String title;
  const FeaturesWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppAssetImages.smallTikSvgLogo),
        AppGaps.wGap5,
        Text(
          title,
          style: AppTextStyles.bodySmallMediumTextStyle,
        )
      ],
    );
  }
}
