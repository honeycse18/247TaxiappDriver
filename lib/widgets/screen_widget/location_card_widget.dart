import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class LocationCardWidget extends StatelessWidget {
  final String dateText;
  final bool isLoading;
  final String timeText;
  final String priceRangeText;
  final String nameText;
  final String genderText;
  final String imageUrl;
  final String ratingText;
  final String addressText;
  final String distanceText;
  final void Function()? onViewDetails;
  final void Function()? onAccept;

  const LocationCardWidget({
    Key? key,
    required this.dateText,
    required this.timeText,
    required this.priceRangeText,
    required this.isLoading,
    required this.nameText,
    required this.genderText,
    required this.imageUrl,
    required this.ratingText,
    required this.addressText,
    required this.distanceText,
    this.onViewDetails,
    this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Showing by location and date',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$dateText At $timeText',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '$priceRangeText SAR',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.green),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(AppAssetImages.star),
                            AppGaps.wGap4,
                            Text(ratingText,
                                style: const TextStyle(fontSize: 8)),
                          ],
                        ),
                      ],
                    ),
                    AppGaps.wGap16,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameText,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          genderText,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                AppGaps.hGap20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(AppAssetImages.location1SVGLogoLine),
                        Container(
                          height: 60,
                          width: 2,
                          color: AppColors.hintTextColor,
                        ),
                        SvgPicture.asset(AppAssetImages.location2SVGLogoLine)
                      ],
                    ),
                    AppGaps.wGap8,
                    Column(
                      children: [
                        LocationStepWidget(
                          timeDistanceText: '6 Mins ($distanceText MI) away',
                          addressText: addressText,
                        ),
                        Divider(),
                        AppGaps.hGap24,
                        LocationStepWidget(
                          timeDistanceText: '6 Mins ($distanceText MI) away',
                          addressText: addressText,
                        ),
                      ],
                    ),
                  ],
                ),
                AppGaps.hGap16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: RawButtonWidget(
                        onTap: onViewDetails,
                        child: Container(
                          height: 60,
                          width: 153,
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: Center(
                              child: Text(
                            'View Details',
                            style: TextStyle(color: AppColors.primaryColor),
                          )),
                        ),
                      ),
                    ),
                    AppGaps.wGap12,
                    Expanded(
                      child: CustomStretchedButtonWidget(
                          isLoading: isLoading,
                          onTap: onAccept,
                          child: const Text('Accept')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LocationStepWidget extends StatelessWidget {
  final String timeDistanceText;
  final String addressText;

  const LocationStepWidget({
    Key? key,
    required this.timeDistanceText,
    required this.addressText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeDistanceText,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                AppGaps.hGap4,
                Text(
                  addressText,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
