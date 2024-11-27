import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/screens/bottom_sheet/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class StartRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  String rideId = '';
  String vehicleId = '';
  String status = '';
  RideDetailsData rideDetails = RideDetailsData.empty();
  Timer? _rideStatusTimer;
  Timer? _locationUpdateTimer;
  LocationModel? currentDriverLocation;
  /*<----------- Ride details from API ----------->*/
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

  /*<----------- Cancle ride from API ----------->*/
  Future<void> cancelRide(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateRideStatus(requestBody);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForCancellingRideTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRide(response);
  }

  onSuccessCancellingRide(RawAPIResponse response) {
    Get.back();
    APIHelper.onError(AppLanguageTranslation
        .rideHasBeenCancelledSuccessfullyTranskey.toCurrentLanguage);
  }

  /*<----------- Bottom button tap ----------->*/
  void onBottomButtonTap({bool showDialogue = true}) async {
    String reason = 'No reason found';
    final Map<String, dynamic> requestBody = {
      '_id': rideId,
    };

    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      reason = res;
      update();
      requestBody['status'] = 'cancelled';
      requestBody['cancel_reason'] = reason;
      cancelRide(requestBody);
    }

    log(reason);
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      rideId = argument;
      update();
    }
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    _getScreenParameter();
    if (Helper.isUserLoggedIn()) {
      getRideDetails();
      startRideStatusChecks();
    }

    super.onInit();
  }

  @override
  void onClose() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
    super.onClose();
  }

  //======================

  void startRideStatusChecks() {
    /* _rideStatusTimer = Timer.periodic(const Duration(seconds: 5), (_) {
    }); */
    checkRideStatus();
  }

  Future<void> checkRideStatus() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      // APIHelper.onError('No response for this operation!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    rideId = response.data.rideStatus.id;
    status = response.data.status;
    vehicleId = response.data.vehicle.id;
    startLocationUpdates(vehicleId);
    update();
  }

  void startLocationUpdates(String vehicleId) {
    _locationUpdateTimer ??= Timer.periodic(const Duration(seconds: 10), (_) {
      final shouldUpdateDriverLocation =
          rideDetails.shouldUpdateDriverLocationFromStatus &&
              rideDetails.id.isNotEmpty;
      // (rideDetails.status == 'reached' || rideDetails.status == 'completed' || rideDetails.status == 'cancelled') == false;
      if (shouldUpdateDriverLocation && rideDetails.id.isNotEmpty) {
        log('shouldUpdateDriverLocation');
        updateDriverLocation(vehicleId);
      } else {
        log('shouldNOTUpdateDriverLocation');
      }
    });
  }

  Future<void> updateDriverLocation(String vehicleId) async {
    final LocationModel? locationModel = await getCurrentPosition();
    if (locationModel != null) {
      Map<String, dynamic> requestBody = {
        'vehicle': vehicleId,
        // 'online': true,
        'location': {
          'lat': locationModel.latitude,
          'lng': locationModel.longitude
        }
      };
      updateDriverStatus(requestBody);
    }
  }

  Future<void> updateDriverStatus(Map<String, dynamic> requestBody) async {
    RawAPIResponse? response = await APIRepo.updateDriverStatus(requestBody);
    if (response == null) {
      // APIHelper.onError('No response for status update!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      APIHelper.onError('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        APIHelper.onError('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      APIHelper.onError('Location permissions are permanently denied');
      return false;
    }

    return true;
  }

  Future<LocationModel?> getCurrentPosition() async {
    final bool hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentDriverLocation = LocationModel(
          latitude: position.latitude, longitude: position.longitude);
      update();
      return currentDriverLocation;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//======================
}
