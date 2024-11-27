import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/api_response/ride_request_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/enums.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/model/screenParameters/select_car_screen_parameter.dart';
import 'package:taxiappdriver/screens/bottom_sheet/start_trip_bottomsheet.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class MyTripListController extends GetxController {
  List<RideHistoryDoc> pendingRideList = [];
  UserDetailsData userDetails = UserDetailsData.empty();

  // RxBool isPendingTabSelected = false.obs;
  PagingController<int, RideHistoryDoc> rideHistoryPagingController =
      PagingController(firstPageKey: 1);
  String status = '';

  Rx<RideHistoryStatusEnum> selectedStatus = RideHistoryStatusEnum.upcoming.obs;

  bool isDateChanges(
      RideHistoryDoc notification, RideHistoryDoc? previousDate) {
    if (previousDate == null) {
      return true;
    }
    final notificationDate = DateTime(notification.createdAt.year,
        notification.createdAt.month, notification.createdAt.day);
    final previousNotificationDate = DateTime(previousDate.createdAt.year,
        previousDate.createdAt.month, previousDate.createdAt.day);
    Duration dateDifference =
        notificationDate.difference(previousNotificationDate);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  void onRideTabTap(RideHistoryStatusEnum value) {
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  void onPendingRideTabTap(RideHistoryStatusEnum value) {
    getPendingRideRequestResponse();
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  RideHistoryDoc? previousDate(int currentIndex, RideHistoryDoc date) {
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    RideHistoryDoc? previousNotification =
        rideHistoryPagingController.value.itemList?[previousIndex];
    return previousNotification;
    // return notification.previousNotification;
  }

  void onRideWidgetTap(
    RideHistoryDoc ride,
  ) {
    //Need Update
    Get.toNamed(AppPageNames.startRideRequestScreen,
        arguments: AcceptedRequestScreenParameter(
            rideId: ride.id,
            selectedCarScreenParameter: SelectCarScreenParameter(
                pickupLocation: LocationModel(
                    latitude: ride.from.location.lat,
                    longitude: ride.from.location.lng,
                    address: ride.from.address),
                dropLocation: LocationModel(
                    latitude: ride.to.location.lat,
                    longitude: ride.to.location.lng,
                    address: ride.to.address))));
  }

  /*<----------- Accept reject ride request----------->*/
  Future<void> acceptRejectRideRequest(String rideId, RideStatus status) async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': status.stringValue
    };
    RawAPIResponse? response =
        await APIRepo.acceptRejectRideRequest(requestBody);
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    _onSuccessUpdateRideRequest(response, status);
  }

  _onSuccessUpdateRideRequest(
      RawAPIResponse response, RideStatus status) async {
    if (status == RideStatus.accepted) {
      Get.bottomSheet(const StartRideBottomSheetScreen(),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: false,
          settings: RouteSettings(arguments: response.data));
    }
    await getPendingRideRequestResponse();
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  /*<----------- Get pending ride request from API ----------->*/
  Future<void> getPendingRideRequestResponse() async {
    RideRequestResponse? response =
        await APIRepo.getPendingRideRequestResponse();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetPendingRideRequestResponse(response);
  }

  void onSuccessGetPendingRideRequestResponse(RideRequestResponse response) {
    pendingRideList = response.data.docs;
    update();
  }

  //------------Get Method----------------

  /*<----------- Get ride history list from API ----------->*/
  Future<void> getRideHistoryList(int currentPageNumber) async {
    final String key = selectedStatus.value.stringValue;
    RideHistoryResponse? response =
        await APIRepo.getRideHistoryList(currentPageNumber, key);
    if (response == null) {
      onErrorGetHireDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetHireDriverList(response);
      return;
    }
    onSuccessGetHireDriverList(response);
  }

  void onErrorGetHireDriverList(RideHistoryResponse? response) {
    rideHistoryPagingController.error = response;
  }

  void onFailureGetHireDriverList(RideHistoryResponse response) {
    rideHistoryPagingController.error = response;
  }

  void onSuccessGetHireDriverList(RideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideHistoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    getPendingRideRequestResponse();
    rideHistoryPagingController.addPageRequestListener((pageKey) {
      getRideHistoryList(pageKey);
    });

    super.onInit();
  }

  @override
  void onClose() {
    rideHistoryPagingController.dispose();
    super.onClose();
  }
}
