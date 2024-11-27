import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/api_response/ride_share_request_socket_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/enums.dart';
import 'package:taxiappdriver/model/fakeModel/intro_content_model.dart';
import 'package:taxiappdriver/screens/bottom_sheet/start_trip_bottomsheet.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class AcceptRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RideShareRequestSocketResponse rideShareRequestDetails =
      RideShareRequestSocketResponse.empty();
  RideHistoryDoc rideHistoryData = RideHistoryDoc.empty();
  FakeRentHistoryList fakeRideHistoryData = FakeRentHistoryList();

  /*<----------- Accept reject ride request----------->*/
  Future<void> acceptRejectRideRequest(String rideId, RideStatus status) async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': status.stringValue
    };
    RawAPIResponse? response =
        await APIRepo.acceptRejectRideRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());

    _onSuccessAddDriver(response, status);
  }

  _onSuccessAddDriver(RawAPIResponse response, RideStatus status) async {
    Get.back(result: true);
    /* if (status.stringValue == 'rejected') {
      Helper.showNotification(
          title: 'Ride Rejected',
          message: 'You Have Rejected The Ride Request',
          payload: '');
    } */
    if (status.stringValue == 'accepted') {
      Get.bottomSheet(const StartRideBottomSheetScreen(),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: false,
          settings: RouteSettings(arguments: response.data));
    }

    // AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is RideShareRequestSocketResponse) {
        rideShareRequestDetails = argument;
        update();
      } else if (argument is RideHistoryDoc) {
        rideHistoryData = argument;
        update();
      }
    }
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameter();
    super.onInit();
  }
}
