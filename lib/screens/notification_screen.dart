import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/controller/notification_screen_controllar.dart';
import 'package:taxiappdriver/model/api_response/notification_list_response.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/notifications_screen_widgets.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<NotificationScreenController>(
      init: NotificationScreenController(),
      global: false,
      builder: (controller) => Scaffold(
          /* <-------- AppBar --------> */
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText:
                  AppLanguageTranslation.notificationTransKey.toCurrentLanguage,
              hasBackButton: true,
              actions: [
                RawButtonWidget(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 24,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryTextColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2))),
                    child: Center(
                        child: Text(
                      AppLanguageTranslation.readAllTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodySemiboldTextStyle
                          .copyWith(color: AppColors.primaryTextColor),
                    )),
                  ),
                  onTap: () {
                    controller.readAllNotification();
                    controller.userNotificationPagingController.refresh();
                  },
                )
              ]),

          /* <-------- Body Content --------> */
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
              ),
              child: RefreshIndicator(
                onRefresh: () async =>
                    controller.userNotificationPagingController.refresh(),
                /* <-------- Notification List view --------> */
                child: PagedListView.separated(
                  pagingController: controller.userNotificationPagingController,
                  builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                      NotificationListItem>(
                    noItemFoundIndicatorBuilder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmptyScreenWidget(
                            isSVGImage: true,
                            localImageAssetURL: AppAssetImages.bellFillIcon,
                            title: AppLanguageTranslation
                                .youHavenoNotificationTranskey
                                .toCurrentLanguage,
                            shortTitle: '',
                          ),
                        ],
                      );
                    },
                    itemBuilder: (context, item, index) {
                      final notification = item;
                      final previousNotification =
                          controller.previousNotification(index, item);
                      final bool isNotificationDateChanges =
                          controller.isNotificationDateChanges(
                              item, previousNotification);
                      return NotificationWidget(
                        action: notification.action,
                        tittle: notification.title,
                        description: notification.message,
                        dateTime: notification.createdAt,
                        isDateChanged: isNotificationDateChanges,
                        notificationType: notification.action,
                        isRead: notification.read,
                        onTap: () {
                          controller.readNotification(notification.id);
                          controller.userNotificationPagingController.refresh();
                        },
                      );
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      /* <-------- 24px height gap --------> */
                      AppGaps.hGap24,
                ),
              ),
            ),
          )),
    );
  }
}
