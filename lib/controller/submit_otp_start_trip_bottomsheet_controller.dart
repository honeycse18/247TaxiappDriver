import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_share_request_socket_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class SubmitOtpStartRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RideShareRequestSocketResponse rideShareRequestDetails =
      RideShareRequestSocketResponse.empty();

  UserDetailsData userDetailsData = UserDetailsData.empty();
  bool isSuccess = false;
  RideDetailsData rideDetails = RideDetailsData.empty();

  TextEditingController otpTextEditingController = TextEditingController();
  String rideId = '';

  /*<----------- Accept reject ride request from API ----------->*/
  Future<void> acceptRejectRideRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': rideId,
      'status': 'started',
      'otp': otpTextEditingController.text,
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessStartRideRequest(response);
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _onSuccessStartRideRequest(RawAPIResponse response) async {
    return isSuccess = true;
  }

  /*<----------- Fetch screen navigation argument----------->*/
  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    rideDetails = response.data;
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is RideDetailsData) {
      rideDetails = argument;
      rideId = rideDetails.id;
      update();
    } else if (argument is String) {
      rideId = argument;
      update();
      getRideDetails();
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    otpTextEditingController.dispose();
    super.dispose();
  }
}
