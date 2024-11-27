import 'dart:async';
import 'dart:developer';
import 'package:location/location.dart' as loc;
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiappdriver/controller/home_screen_controller.dart';
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/ride_share_request_socket_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/model/screenParameters/select_car_screen_parameter.dart';
import 'package:taxiappdriver/screens/bottom_sheet/recieve_ride_bottomsheet.dart';
import 'package:taxiappdriver/screens/unknown_screen.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class HomeNavigatorScreenController extends GetxController {
  int currentPageIndex = 0;
  int currentTabIndex = 0;
  String titleText = 'Home';
  late loc.Location location;
  loc.Location? currentLocation;
  Rx<LatLng> userLocation = Rx<LatLng>(LatLng(0.0, 0.0));
  Rx<RideShareRequestSocketResponse> rideShareRequest =
      RideShareRequestSocketResponse.empty().obs;
  UserDetailsData userDetails = UserDetailsData.empty();
  SocketController socketController = Get.find<SocketController>();
  // SocketController socketController = Get.put<SocketController>(SocketController());
  bool _isOnlineOfflineLoading = false;
  bool get isOnlineOfflineLoading => _isOnlineOfflineLoading;
  set isOnlineOfflineLoading(bool value) {
    _isOnlineOfflineLoading = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  RideShareRequestSocketResponse rideRequest =
      RideShareRequestSocketResponse.empty();

  final pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  bool _isOnline = false;
  bool get isOnline => _isOnline;
  set isOnline(bool value) {
    _isOnline = value;
    update();
  }

  Widget nestedScreenWidget = const Scaffold();
  LocationModel? currentDriverLocation;
  Position? _currentPosition;

  void toggleOnlineStatus() {
    if (userDetails.subscriptions.id == '' || userDetails.walletBalance < 1) {
      isOnline = false;
    }
    update();
  }

  /*  /*<-----------Socket initialize ----------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

/*   dynamic onNewRideRequest(dynamic data) {
    log('data socket');
    final RideShareRequestSocketResponse mapData =
        RideShareRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    rideShareRequest.value = mapData;
    update();
  } */ */
  /*<-----------Get socket response for new ride request ----------->*/
  void onNewRideRequest(dynamic data) async {
    log('data socket');
    RideShareRequestSocketResponse? response =
        RideShareRequestSocketResponse.empty();
    if (data is RideShareRequestSocketResponse) {
      response = data;
      update();
    }
    log(response.toJson().toString());
    if (response.id.isNotEmpty) {
      rideRequest = response;
      update();
      await Get.bottomSheet(const ReceiveRideBottomSheetScreen(),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: false,
          settings: RouteSettings(arguments: rideRequest));
      await getLoggedInUserDetails();
    }
  }

  Widget bottomMenuButton(String name, String image, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 120,
        height: 44,
        decoration: ShapeDecoration(
          color: (currentPageIndex == index)
              ? AppColors.primary50Color
              : AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.04,
                color: (currentPageIndex == index)
                    ? AppColors.primaryColor
                    : AppColors.bodyTextColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPictureAssetWidget(
              image,
              color: (currentPageIndex == index)
                  ? AppColors.primaryColor
                  : AppColors.bodyTextColor,
            ),
            AppGaps.wGap5,
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: (currentPageIndex == index)
                        ? AppColors.primaryColor
                        : AppColors.bodyTextColor,
                    fontSize: 14,
                    fontWeight: (currentPageIndex == index)
                        ? FontWeight.w600
                        : FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (Helper.isUserLoggedIn()) {
          homeNavigatorTabIndex(index);
        } else {
          selectHomeNavigatorTabIndex(index);
        }
      },
    );
  }

  void homeNavigatorTabIndex(int index) {
    currentPageIndex = index;

    setCurrentTab();
  }

  final notchBottomBarController = NotchBottomBarController(index: 0);

  int maxCount = 4;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void selectHomeNavigatorTabIndex(int index) {
    if (index == 1) {
      log('message');
    } else {
      // APIHelper.onFailure('Please Login First', '');
      Get.toNamed(AppPageNames.unknownScreen);
    }

    setCurrentTab();
  }

  /* <-------- Select current tab screen --------> */
  void setCurrentTab() {
    const int bookingHistoryScreenIndex = 0;
    const int moreScreenIndex = 2;
    switch (currentPageIndex) {
      case bookingHistoryScreenIndex:
        nestedScreenWidget = const UnknownPage();
        titleText = 'Home';
        currentTabIndex = 0;
        break;
      case moreScreenIndex:
        nestedScreenWidget = const UnknownPage();
        titleText = 'My Wallet';
        currentTabIndex = 2;

        break;
      /* case homeScreenIndex:
        nestedScreenWidget = const UnknownPage();
        titleText = '';
        break; */
      default:
        // Invalid page index set tab to dashboard screen
        nestedScreenWidget = const UnknownPage();
        titleText = '';
    }
    update();
  }

  Future<void> getLoggedInUserDetails(
      {bool shouldStopOnlineStatusLoading = false}) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (shouldStopOnlineStatusLoading) {
      isOnlineOfflineLoading = false;
    }
    if (response == null) {
      isOnlineOfflineLoading = false;
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      isOnlineOfflineLoading = false;
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) async {
    userDetails = response.data;
    isOnline = userDetails.vehicle.online;
    if ((userDetails.rideStatus.id.isNotEmpty)) {
      await Get.toNamed(AppPageNames.startRideRequestScreen,
          arguments: AcceptedRequestScreenParameter(
              rideId: userDetails.rideStatus.id,
              selectedCarScreenParameter: SelectCarScreenParameter(
                  pickupLocation: LocationModel(
                      latitude: userDetails.rideStatus.from.location.lat,
                      longitude: userDetails.rideStatus.from.location.lng,
                      address: userDetails.rideStatus.from.address),
                  dropLocation: LocationModel(
                      latitude: userDetails.rideStatus.to.location.lat,
                      longitude: userDetails.rideStatus.to.location.lng,
                      address: userDetails.rideStatus.to.address))));
      await getLoggedInUserDetails();
    }
    update();
  }

  void goOnlineOffline() async {
    // isLoading = true;
    // update();
    isOnlineOfflineLoading = true;
    await getLoggedInUserDetails(shouldStopOnlineStatusLoading: false);
    if ((userDetails.vehicle.id != '') &&
        (userDetails.vehicle.status == 'approved') &&
        (userDetails.status == 'approved') &&
        ((userDetails.subscriptions.id != '') ||
            (userDetails.walletBalance >= 1))) {
      onStatusUpdateButtonTap();
    } else if (userDetails.status != 'approved') {
      isOnlineOfflineLoading = false;
      APIHelper.onFailure('Your Account Is Not Approved Yet');
    } else if (userDetails.vehicle.status != 'approved') {
      isOnlineOfflineLoading = false;
      APIHelper.onFailure('You Have No Active Registered Vehicle');
    } else {
      isOnlineOfflineLoading = false;
      isOnline = false;
      AppDialogs.showErrorDialog(
          messageText:
              'You have no active subscriptions or enough wallet balance');
    }
    update();
  }

  void onStatusUpdateButtonTap() {
    selectHomeNavigatorTabIndex(1);
    vehicleStatusOnline(userDetails.vehicle.id, isOnline);
  }

  /*<----------- Vahicle status from API----------->*/
  Future<void> vehicleStatusOffline(String id, bool value) async {
    isLoading = true;
    update();
    Map<String, dynamic> requestBody = {
      'vehicle': id,
      'online': !userDetails.vehicle.online,
      'location': {
        'lat': userLocation.value.latitude,
        'lng': userLocation.value.longitude
      },
    };
    RawAPIResponse? response = await APIRepo.vehicleStatusOnline(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      isLoading = false;

      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      isLoading = false;

      return;
    }
    log(response.toJson().toString());
    isLoading = false;
  }

  /*<----------- Vahicle status from API----------->*/
  Future<void> vehicleStatusOnline(String id, bool value) async {
    Map<String, dynamic> requestBody = {
      'vehicle': id,
      'online': !userDetails.vehicle.online,
      'location': {
        'lat': userLocation.value.latitude,
        'lng': userLocation.value.longitude
      },
    };
    RawAPIResponse? response = await APIRepo.vehicleStatusOnline(requestBody);
    if (response == null) {
      isOnlineOfflineLoading = false;
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      isOnlineOfflineLoading = false;
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessOnlineVehicle(response);
  }

  _onSuccessOnlineVehicle(RawAPIResponse response) {
    // Get.snackbar(
    //     AppLanguageTranslation.successTransKey.toCurrentLanguage, response.msg,
    //     backgroundColor: AppColors.successColor.withOpacity(0.3),
    //     colorText: Colors.black,
    //     snackPosition: SnackPosition.BOTTOM);

    update();
    getLoggedInUserDetails(shouldStopOnlineStatusLoading: true);
  }

  /*<----------- request location permission from API----------->*/
  Future<void> _requestPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == loc.PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      var currentLocation = await location.getLocation();
      LatLng latLng = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
      userLocation.value = latLng;
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  StreamSubscription<RideShareRequestSocketResponse>? listener;
  void getScreenParams() {
    dynamic params = Get.arguments;
    if (params != null) {
      if (params is int) {
        selectHomeNavigatorTabIndex(params);
        currentPageIndex = params;
        update();
      }
    }
    update();
  }

  @override
  void onInit() async {
    getScreenParams();
    location = loc.Location();
    userDetails = Helper.getUser();
    await getCurrentLocation();
    listener ??= socketController.rideShareRequest.listen((p0) {
      onNewRideRequest(p0);
    });
    _requestPermission();
    getLoggedInUserDetails();
    toggleOnlineStatus();
    super.onInit();
  }

  @override
  void onClose() {
    dispose();
    onAsyncClose();
    super.onClose();
  }

  Future<void> onAsyncClose() async {
    await listener?.cancel();
    listener = null;
  }
}
