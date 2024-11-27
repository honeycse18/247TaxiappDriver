import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/* <--------  Ride History List Item Widget  --------> */
class RideHistoryListItemWidget extends StatelessWidget {
  final String driverImage;
  final String driverNumber;
  final String carModel;
  final String currency;
  final String distance;
  final double rate;
  final String driverName;
  final String carName;
  final String pickupLocation;
  final String dropLocation;
  final bool showCallChat;
  final DateTime time;
  final DateTime date;
  final bool isDateChanged;

  final void Function()? onTap;
  final void Function()? onSendTap;

  const RideHistoryListItemWidget({
    Key? key,
    this.onTap,
    this.onSendTap,
    required this.driverImage,
    required this.driverNumber,
    required this.pickupLocation,
    required this.dropLocation,
    this.showCallChat = false,
    required this.time,
    required this.date,
    required this.driverName,
    required this.isDateChanged,
    required this.carModel,
    required this.carName,
    required this.currency,
    required this.rate,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDateChanged) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              dayText,
              style: AppTextStyles.titlesemiSmallMediumTextStyle
                  .copyWith(color: AppColors.primaryTextColor),
            ),
          ),
          AppGaps.hGap12,
          _RideHistoryListWidget(
              driverNumber: driverNumber,
              distance: distance,
              currency: currency,
              rate: rate,
              carName: carName,
              carModel: carModel,
              driverName: driverName,
              showCallChat: showCallChat,
              onSendTap: onSendTap,
              pickupLocation: pickupLocation,
              dropLocation: dropLocation,
              date: date,
              driverImage: driverImage,
              time: time,
              isDateChanged: isDateChanged,
              onTap: onTap),
        ],
      );
    }
    return _RideHistoryListWidget(
        driverNumber: driverNumber,
        distance: distance,
        currency: currency,
        rate: rate,
        carName: carName,
        carModel: carModel,
        driverName: driverName,
        showCallChat: showCallChat,
        onSendTap: onSendTap,
        pickupLocation: pickupLocation,
        dropLocation: dropLocation,
        date: date,
        driverImage: driverImage,
        time: time,
        isDateChanged: isDateChanged,
        onTap: onTap);
  }

  String get dayText {
    if (Helper.isToday(date)) {
      return AppLanguageTranslation.todayTransKey.toCurrentLanguage;
    }
    if (Helper.wasYesterday(date)) {
      return AppLanguageTranslation.yesterdayTransKey.toCurrentLanguage;
    }
    if (Helper.isTomorrow(date)) {
      return AppLanguageTranslation.tomorrowTransKey.toCurrentLanguage;
    }
    return Helper.ddMMMyyyyFormattedDateTime(date);
  }
}

class _RideHistoryListWidget extends StatelessWidget {
  final String driverImage;
  final String driverName;
  final String driverNumber;
  final String carModel;
  final String carName;
  final String distance;
  final double rate;
  final String currency;
  final String pickupLocation;
  final String dropLocation;
  final bool showCallChat;
  final DateTime time;
  final DateTime date;
  final bool isDateChanged;

  final void Function()? onTap;
  final void Function()? onSendTap;
  const _RideHistoryListWidget({
    this.onTap,
    this.onSendTap,
    required this.driverImage,
    required this.driverNumber,
    required this.pickupLocation,
    required this.dropLocation,
    this.showCallChat = false,
    required this.time,
    required this.date,
    required this.driverName,
    required this.isDateChanged,
    required this.carModel,
    required this.carName,
    required this.rate,
    required this.currency,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
        onTap: onTap,
        child: Container(
            height: showCallChat ? 290 : 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CachedNetworkImageWidget(
                        imageURL: driverImage,
                        imageBuilder: (context, imageProvider) => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    AppGaps.wGap12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            driverName,
                            style: AppTextStyles.bodyLargeSemiboldTextStyle
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          /* AppGaps.hGap4,
                          Text(
                            '★ 4.9 (531 Ride)',
                            style: AppTextStyles.smallestTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ), */
                          AppGaps.hGap4,
                          /* Row(
                            children: [
                              Expanded(
                                child: Text(
                                  carName,
                                  style: AppTextStyles.bodySmallMediumTextStyle
                                      .copyWith(color: AppColors.bodyTextColor),
                                ),
                              ),
                              Text(
                                ' ($carModel)',
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ), */
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                currency,
                                style: AppTextStyles.bodyLargeBoldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                rate.toStringAsFixed(2),
                                style: AppTextStyles.bodyLargeBoldTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                          AppGaps.hGap4,
                          Text(
                            Helper.hhmmFormattedDateTime(time),
                            style: AppTextStyles.bodyTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (showCallChat) AppGaps.hGap8,
                if (showCallChat)
                  Row(
                    children: [
                      RawButtonWidget(
                        borderRadiusValue: 12,
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2)),
                              border:
                                  Border.all(color: AppColors.fromBorderColor)),
                          child: const Center(child: Icon(Icons.call)),
                        ),
                        onTap: () {
                          launchUrl(Uri(scheme: 'tel', path: driverNumber));
                          
                        },
                      ),
                      AppGaps.wGap8,
                      Expanded(
                          child: CustomMessageTextFormField(
                        onTap: onSendTap,
                        isReadOnly: true,
                        suffixIcon: const Icon(Icons.send),
                        boxHeight: 55,
                        hintText: 'Type your message..',
                      ))
                    ],
                  ),
                AppGaps.hGap16,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SvgPictureAssetWidget(
                          AppAssetImages.location1SVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: 1,
                          color: AppColors.bodyTextColor,
                        ),
                        const SvgPictureAssetWidget(
                          AppAssetImages.location2SVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                      ],
                    ),
                    AppGaps.wGap8,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .pickupLocationTransKey.toCurrentLanguage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                        AppGaps.hGap4,
                        Text(
                          pickupLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyLargeMediumTextStyle,
                        ),
                        AppGaps.hGap6,
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: AppColors.bodyTextColor,
                                height: 1,
                                width:
                                    MediaQuery.of(context).size.height * 0.30,
                              ),
                            ),
                            Container(
                              width: 65,
                              height: 28,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF919BB3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                              child: Center(
                                  child: Text(
                                distance,
                                style: AppTextStyles.bodySmallMediumTextStyle
                                    .copyWith(color: Colors.white),
                              )),
                            ),
                          ],
                        ),
                        AppGaps.hGap5,
                        Text(
                          AppLanguageTranslation
                              .dropLocationTransKey.toCurrentLanguage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle
                              .copyWith(color: AppColors.bodyTextColor),
                        ),
                        AppGaps.hGap4,
                        Text(
                          dropLocation,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyLargeMediumTextStyle,
                        ),
                      ],
                    ))
                  ],
                )
              ],
            )));
  }
}
