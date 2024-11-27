import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class HistoryListScreenWidget extends StatelessWidget {
  final String userName;
  final bool isRideNow;

  final String userImage;
  final String distance;
  final String pickLocation;
  final String dropLocation;
  final double amount;
  final double rating;
  final void Function()? onTap;
  final void Function()? onAcceptTap;
  final void Function()? onRejectTap;

  const HistoryListScreenWidget({
    super.key,
    required this.userName,
    required this.userImage,
    required this.distance,
    required this.pickLocation,
    required this.dropLocation,
    required this.amount,
    required this.rating,
    this.onTap,
    this.isRideNow = false,
    this.onAcceptTap,
    this.onRejectTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
      paddingValue: const EdgeInsets.all(12),
      onTap: onTap,
      hasShadow: true,
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CachedNetworkImageWidget(
                imageURL: userImage,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            AppGaps.wGap10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: AppColors.primaryTextColor),
                ),
                AppGaps.hGap4,
                /* Row(
                  children: [
                    const SvgPictureAssetWidget(
                      AppAssetImages.starSVGLogoSolid,
                      height: 8,
                      width: 8,
                      color: AppColors.primaryColor,
                    ),
                    AppGaps.wGap6,
                    Text(
                      '$rating ( 531 ${AppLanguageTranslation.reviewTransKey.toCurrentLanguage} )',
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    )
                  ],
                ) */
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Helper.getCurrencyFormattedWithDecimalAmountText(amount),
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap6,
                Text(
                  '$distance 1.5 Minits',
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            )
          ],
        ),
        AppGaps.hGap16,
        /* Row(
          children: [
            RawButtonWidget(
              borderRadiusValue: 12,
              child: Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: AppColors.primaryBorderColor)),
                child: const Center(
                    child: SvgPictureAssetWidget(
                  AppAssetImages.callingSVGLogoLine,
                  height: 15,
                  width: 15,
                )),
              ),
              onTap: () {},
            ),
            AppGaps.wGap10,
            Expanded(
              child: CustomMessageTextFormField(
                boxHeight: 44,
                isReadOnly: true,
                onTap: () {},
                hintText: 'Message Your driver..',
                suffixIcon: const SvgPictureAssetWidget(
                  AppAssetImages.sendSVGLogoLine,
                  height: 18,
                  width: 18,
                ),
              ),
            )
          ],
        ), */
        /* AppGaps.hGap12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Start Date & Time ',
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
            ),
            const Text(
              '24 Oct,2022  I 05:40 AM',
              style: AppTextStyles.bodyLargeMediumTextStyle,
            )
          ],
        ), */
        AppGaps.hGap12,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SvgPictureAssetWidget(
              AppAssetImages.location1SVGLogoLine,
              height: 16,
              width: 16,
              color: AppColors.bodyTextColor,
            ),
            AppGaps.wGap4,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick Location',
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                  AppGaps.hGap6,
                  Text(
                    pickLocation,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
        AppGaps.hGap14,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SvgPictureAssetWidget(
              AppAssetImages.location2SVGLogoLine,
              height: 16,
              width: 16,
              color: AppColors.bodyTextColor,
            ),
            AppGaps.wGap8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop Location',
                    style: AppTextStyles.bodySmallTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                  AppGaps.hGap4,
                  Text(
                    dropLocation,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeMediumTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
        AppGaps.hGap12,
        Row(
          children: [
            Expanded(
                child: Container(
              height: 1,
              color: AppColors.fromBorderColor,
            )),
          ],
        ),
        AppGaps.hGap12,
        Row(
          children: [
            Expanded(
                child: CustomStretchedOnlyTextButtonWidget(
              buttonText: 'Reject',
              onTap: onRejectTap,
            )),
            AppGaps.wGap69,
            Expanded(
                child: RawButtonWidget(
              borderRadiusValue: 8,
              onTap: onAcceptTap,
              child: Container(
                height: 44,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                    child: Text(
                  '${AppLanguageTranslation.acceptTransKey.toCurrentLanguage}  →',
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: Colors.white),
                )),
              ),
            ))
          ],
        )
      ]),
    );
  }
}
