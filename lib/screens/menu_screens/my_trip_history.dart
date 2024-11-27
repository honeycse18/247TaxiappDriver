import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/controller/schedule_ride_list_controller.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/enums.dart';
import 'package:taxiappdriver/screens/bottom_sheet/recieve_ride_bottomsheet.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/history_screen_widgets.dart';
import 'package:taxiappdriver/widgets/ride_history_screen_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/Tab_list_screen_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';
import 'package:taxiappdriver/widgets/screen_widget/location_card_widget.dart';

class MyTripList extends StatelessWidget {
  const MyTripList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTripListController>(
        global: false,
        init: MyTripListController(),
        builder: (controller) => Scaffold(
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleText: 'My Trips',
                hasBackButton: true,
              ),
              /* body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: LocationCardWidget(
                  dateText: '24 Apr 2024',
                  timeText: '10 Am',
                  priceRangeText: '50-100',
                  nameText: 'Sergio Ramasis',
                  genderText: 'Male',
                  imageUrl:
                      'https://static.vecteezy.com/system/resources/thumbnails/011/675/374/small_2x/man-avatar-image-for-profile-png.png',
                  ratingText: '4.9',
                  addressText: '2972 Westheimer Rd. Santa ..',
                  distanceText: '6 Mins (2.6 ',
                  onViewDetails: () {
                    Get.toNamed(AppPageNames.acceptTripRequestScreen);
                  },
                  onAccept: () {
                    AppDialogs.showRideAcceptDialog(
                        messageText:
                            'When you accept you cannot cancel without cancellation fee',
                        onYesAcceptTap: () async {
                          Get.toNamed(AppPageNames.acceptTripRequestScreen);
                        });
                  },
                ),
              ),
            ) */
              body: ScaffoldBodyWidget(
                child: RefreshIndicator(
                  onRefresh: () async => controller.selectedStatus.value ==
                          RideHistoryStatusEnum.upcoming
                      ? controller.getPendingRideRequestResponse()
                      : controller.rideHistoryPagingController.refresh(),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap28,
                      ),
                      SliverToBoxAdapter(
                          child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: AppColors.myRideTabColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /* TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .pending.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.pending,
                                onTap: () {
                                  controller.onPendingRideTabTap(
                                      RideHistoryStatusEnum.pending);
                                },
                              ), */
                              TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .upcoming.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.upcoming,
                                onTap: () {
                                  controller.onRideTabTap(
                                      RideHistoryStatusEnum.upcoming);
                                },
                              ),
                              /* <-------- 10px width gap --------> */
                              AppGaps.wGap10,
                              TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .started.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.started,
                                onTap: () {
                                  controller.onRideTabTap(
                                      RideHistoryStatusEnum.started);
                                },
                              ),
                              AppGaps.wGap10,
                              TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .reached.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.reached,
                                onTap: () {
                                  controller.onRideTabTap(
                                      RideHistoryStatusEnum.reached);
                                },
                              ),
                              /* <-------- 10px width gap --------> */
                              AppGaps.wGap10,
                              TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .complete.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.complete,
                                onTap: () {
                                  controller.onRideTabTap(
                                      RideHistoryStatusEnum.complete);
                                },
                              ),
                              /* <-------- 10px width gap --------> */
                              AppGaps.wGap10,
                              TabStatusWidget(
                                text: RideHistoryStatusEnum
                                    .cancelled.stringValueForView,
                                isSelected: controller.selectedStatus.value ==
                                    RideHistoryStatusEnum.cancelled,
                                onTap: () {
                                  controller.onRideTabTap(
                                      RideHistoryStatusEnum.cancelled);
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap28),
                      Obx(() {
                        switch (controller.selectedStatus.value) {
                          //pending ride list view
                          /* case RideHistoryStatusEnum.pending:
                            return controller.pendingRideList.isEmpty
                                ? SliverToBoxAdapter(
                                    child: Center(
                                      child: EmptyScreenWidget(
                                          isSVGImage: false,
                                          localImageAssetURL:
                                              AppAssetImages.upcomingRequest,
                                          title: AppLanguageTranslation
                                              .youHaveNoPendingRequestsTranskey
                                              .toCurrentLanguage,
                                          shortTitle: ''),
                                    ),
                                  )
                                : SliverList.separated(
                                    itemBuilder: (context, index) {
                                      final rentListHistory =
                                          controller.pendingRideList[index];
                                      return HistoryListScreenWidget(
                                        onAcceptTap: () {
                                          controller.acceptRejectRideRequest(
                                              rentListHistory.id,
                                              RideStatus.accepted);
                                        },
                                        onRejectTap: () =>
                                            controller.acceptRejectRideRequest(
                                                rentListHistory.id,
                                                RideStatus.rejected),
                                        onTap: () {
                                          Get.bottomSheet(
                                              const ReceiveRideBottomSheetScreen(),
                                              settings: RouteSettings(
                                                  arguments: rentListHistory),
                                              isScrollControlled: true);
                                        },
                                        amount: rentListHistory.total,
                                        userImage: rentListHistory.user.image,
                                        userName: rentListHistory.user.name,
                                        dropLocation:
                                            rentListHistory.to.address,
                                        pickLocation:
                                            rentListHistory.from.address,
                                        rating: 3,
                                        distance: rentListHistory.distance.text,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        AppGaps.hGap16,
                                    itemCount:
                                        controller.pendingRideList.length,
                                  ); */

                          case RideHistoryStatusEnum.upcoming:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 231,
                                      isSVGImage: false,
                                      localImageAssetURL:
                                          AppAssetImages.emptyHistoryIconImage,
                                      title:
                                          'You Have No Upcoming Ride History',
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);
                                //Ride History List view widget
                                return RideHistoryListItemWidget(
                                  driverNumber: rideHistory.driver.phone,
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatusEnum
                                          .upcoming.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                  /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id);
                                }, */
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );

                          case RideHistoryStatusEnum.started:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 231,
                                      isSVGImage: false,
                                      localImageAssetURL:
                                          AppAssetImages.emptyHistoryIconImage,
                                      title: 'You Have No Ongoing Ride History',
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);

                                return RideHistoryListItemWidget(
                                  driverNumber: rideHistory.driver.phone,
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatusEnum
                                          .upcoming.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                  /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case RideHistoryStatusEnum.reached:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 231,
                                      isSVGImage: false,
                                      localImageAssetURL:
                                          AppAssetImages.emptyHistoryIconImage,
                                      title: 'You Have No Reached Ride History',
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);

                                return RideHistoryListItemWidget(
                                  driverNumber: rideHistory.driver.phone,
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatusEnum
                                          .upcoming.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                  /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );

                          case RideHistoryStatusEnum.complete:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 231,
                                      isSVGImage: false,
                                      localImageAssetURL:
                                          AppAssetImages.emptyHistoryIconImage,
                                      title:
                                          'You Have No Completed Ride History',
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);

                                return RideHistoryListItemWidget(
                                  driverNumber: rideHistory.driver.phone,
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatusEnum
                                          .upcoming.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                  /* dateTime: rideHistoryListItem.date,
                                dropLocation: rideHistoryListItem.to.address,
                                pickupLocation:
                                    rideHistoryListItem.from.address,
                                userImage: rideHistoryListItem.user.image,
                                userName: rideHistoryListItem.user.name,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.startRideRequestScreen,
                                      arguments: rideHistoryListItem);
                                },
                                onSendTap: () {
                                  /* Get.toNamed(AppPageNames.chatScreen,
                                              arguments:
                                                  rideHistoryListItem.user.id); */
                                }, */
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case RideHistoryStatusEnum.cancelled:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.rideHistoryPagingController,
                              builderDelegate:
                                  PagedChildBuilderDelegate<RideHistoryDoc>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                return const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                      height: 231,
                                      isSVGImage: false,
                                      localImageAssetURL:
                                          AppAssetImages.emptyHistoryIconImage,
                                      title:
                                          'You Have No Cancelled Ride History',
                                    ),
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final RideHistoryDoc rideHistory = item;
                                final previousDate =
                                    controller.previousDate(index, item);
                                final bool isDateChanges = controller
                                    .isDateChanges(item, previousDate);

                                return RideHistoryListItemWidget(
                                  driverNumber: rideHistory.driver.phone,
                                  distance: rideHistory.distance.text,
                                  rate: rideHistory.total,
                                  currency: rideHistory.currency.symbol,
                                  carName: rideHistory.ride.name,
                                  carModel: rideHistory.ride.model,
                                  isDateChanged: isDateChanges,
                                  driverName: rideHistory.driver.name,
                                  showCallChat: rideHistory.status ==
                                      RideHistoryStatusEnum
                                          .upcoming.stringValue,
                                  onSendTap: () {
                                    Get.toNamed(AppPageNames.chatScreen,
                                        arguments: rideHistory.driver.id);
                                  },
                                  pickupLocation: rideHistory.from.address,
                                  dropLocation: rideHistory.to.address,
                                  onTap: () => controller.onRideWidgetTap(item),
                                  date: rideHistory.date,
                                  driverImage: rideHistory.driver.image,
                                  time: rideHistory.date,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ));
  }
}
