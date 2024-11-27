import 'package:flutter/material.dart';
import 'package:taxiappdriver/model/fakeModel/intro_content_model.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/// Single notification entry widget from notification group
class SingleNotificationWidget extends StatelessWidget {
  final FakeNotificationModel notification;
  final void Function()? onTap;

  const SingleNotificationWidget({
    Key? key,
    required this.notification,
    this.onTap,
  }) : super(key: key);

  TextStyle? _getTextStyle(FakeNotificationTextModel notificationText) {
    if (notificationText.isBoldText) {
      return const TextStyle(fontWeight: FontWeight.w600);
    } else if (notificationText.isHashText) {
      return const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    } else if (notificationText.isColoredText) {
      return const TextStyle(color: AppColors.primaryColor);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead
                    ? AppColors.bodyTextColor
                    : AppColors.primaryColor),
          ),
          AppGaps.wGap16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: notification.isRead
                              ? AppColors.bodyTextColor
                              : AppColors.primaryTextColor,
                          height: 1.5),
                      children: notification.texts
                          .map((notificationText) => TextSpan(
                              text: notificationText.text,
                              style: _getTextStyle(notificationText)))
                          .toList()),
                ),
                AppGaps.hGap8,
                Text(notification.timeText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.bodyTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification group widget from date wise
/* class NotificationDateGroupWidget extends StatelessWidget {
  const NotificationDateGroupWidget({
    Key? key,
    required this.notificationDateGroup,
    required this.outerIndex,
  }) : super(key: key);

  final FakeNotificationDateGroupModel notificationDateGroup;
  final int outerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notificationDateGroup.dateHumanReadableText,
            style: Theme.of(context).textTheme.labelLarge),
        AppGaps.hGap24,
        /* <---- Notification list under a date 
                 category ----> */
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => AppGaps.hGap24,
          itemCount: FakeData
              .fakeNotificationDateGroups[outerIndex].groupNotifications.length,
          itemBuilder: (context, index) {
            /// Single notification
            final notification = FakeData.fakeNotificationDateGroups[outerIndex]
                .groupNotifications[index];
            return SingleNotificationWidget(notification: notification);
          },
        ),
      ],
    );
  }
} */

/* <--------  Notification Widget --------> */
class NotificationWidget extends StatelessWidget {
  final bool isRead;
  final String notificationType;
  final String description;
  final String action;
  final String tittle;
  final DateTime dateTime;
  final bool isDateChanged;
  final void Function()? onTap;

  const NotificationWidget({
    Key? key,
    this.isRead = true,
    required this.notificationType,
    this.onTap,
    required this.dateTime,
    required this.action,
    required this.isDateChanged,
    this.description = '',
    this.tittle = '',
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
              style: AppTextStyles.notificationDateSection,
            ),
          ),
          AppGaps.hGap24,
          _NotificationWidget(
              action: action,
              isRead: isRead,
              notificationType: notificationType,
              dateTime: dateTime,
              description: description,
              tittle: tittle,
              isDateChanged: isDateChanged,
              onTap: onTap),
        ],
      );
    }
    return _NotificationWidget(
        action: action,
        isRead: isRead,
        notificationType: notificationType,
        dateTime: dateTime,
        description: description,
        tittle: tittle,
        isDateChanged: isDateChanged,
        onTap: onTap);
  }

  String get dayText {
    if (Helper.isToday(dateTime)) {
      return AppLanguageTranslation.todayTransKey.toCurrentLanguage;
    }
    if (Helper.wasYesterday(dateTime)) {
      return AppLanguageTranslation.yesterdayTransKey.toCurrentLanguage;
    }
    if (Helper.isTomorrow(dateTime)) {
      return AppLanguageTranslation.tomorrowTransKey.toCurrentLanguage;
    }
    return Helper.ddMMMyyyyFormattedDateTime(dateTime);
  }
}

class _NotificationWidget extends StatelessWidget {
  final bool isRead;
  final String notificationType;
  final String action;
  final DateTime dateTime;
  final bool isDateChanged;
  final String description;
  final String tittle;
  final void Function()? onTap;
  const _NotificationWidget({
    Key? key,
    this.isRead = true,
    required this.notificationType,
    required this.dateTime,
    required this.isDateChanged,
    this.onTap,
    this.description = '',
    required this.action,
    this.tittle = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        isRead: isRead,
        onTap: onTap,
        borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.primaryTextColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Stack(
                children: [
                  /* const SvgPictureAssetWidget(
                      color: AppColors.primaryColor,
                      AppAssetImages.bellFillIcon), */
                  isRead
                      ? const Icon(
                          Icons.notifications,
                          color: AppColors.primaryColor,
                        )
                      : const Icon(
                          Icons.notification_add,
                          color: AppColors.primaryColor,
                        ),
                  Positioned(
                    right: -1,
                    top: -1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: NotificationDotWidget(isRead: isRead),
                    ),
                  )
                ],
              )),
            ),
            AppGaps.wGap16,
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tittle,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ],
                ),
                AppGaps.hGap4,
                Text.rich(
                    TextSpan(children: [
                      TextSpan(text: description),
                    ]),
                    style: AppTextStyles.bodySmallTextStyle.copyWith(
                        color: isRead
                            ? AppColors.primaryTextColor.withOpacity(0.4)
                            : AppColors.primaryTextColor)),
                AppGaps.hGap4,
                Text(
                  Helper.getRelativeDateTimeText(dateTime),
                  style: const TextStyle(
                    color: AppColors.bodyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ))
          ]),
        ));
  }
}
