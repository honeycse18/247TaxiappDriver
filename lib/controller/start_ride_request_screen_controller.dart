import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/google_map_poly_lines_response.dart';
import 'package:taxiappdriver/model/api_response/payment_socket.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/screens/bottom_sheet/choose_reason_ride_cancel_bottomsheet.dart';
import 'package:taxiappdriver/screens/bottom_sheet/submit_otp_screen_bottomsheet.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class StartRequestScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /*<----------- Initialize variables ----------->*/
  UserDetailsData userDetailsData = UserDetailsData.empty();
  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();
  RideDetailsData ridePrimaryDetails = RideDetailsData.empty();
  RideHistoryDoc rideHistoryData = RideHistoryDoc.empty();
  RideHistoryDoc rideData = RideHistoryDoc.empty();
  AcceptedRequestScreenParameter? screenParameter;
  Timer? _rideStatusTimer;
  Timer? _locationUpdateTimer;
  LocationModel? currentDriverLocation;
  String rideId = '';
  String vehicleId = '';
  String paymentId = '';
  RxString status = 'unknown'.obs;
  String cancelReason = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  late AnimationController _animationController;
  late Animation<LatLng> _latLngAnimation;
  LatLng cameraPosition = const LatLng(0, 0);
  double zoomLevel = 12;
  double maxDistance = 0;
  late GoogleMapController googleMapController;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolyLines = {};

  final pickupMarkerId = 'pickUpMarkerId';
  final dropMarkerId = 'dropMarkerId';
  final List<LocationModel> polyLinePoints = [];
  LocationModel? pickupLocation;
  LocationModel? dropLocation;
  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  _addPickUpAndDropMarkers() async {
    var pickupIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.pickupMarkerPngIcon);
    var dropIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(70, 70)),
        AppAssetImages.dropMarkerPngIcon);
    googleMapMarkers.add(Marker(
        markerId: MarkerId(pickupMarkerId),
        position: LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
        icon: pickupIcon));
    googleMapMarkers.add(Marker(
        markerId: MarkerId(dropMarkerId),
        position: LatLng(dropLocation!.latitude, dropLocation!.longitude),
        icon: dropIcon));
  }

  _assignParameters() async {
    _addPickUpAndDropMarkers();
    /* googleMapPolyLines.add(Polyline(
        polylineId: PolylineId('polyLineId'),
        color: Colors.blue,
        points: [
          LatLng(pickupLocation!.latitude, pickupLocation!.longitude),
          LatLng(dropLocation!.latitude, dropLocation!.longitude),
        ],
        width: 5)); */
    getPolyLines(
        // googleMapPolyLines,
        pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude);
    update();
  }

  /*<----------- Google map poly line  ----------->*/
  Future<void> getPolyLines(
      /* Set<Polyline> googleMapPolyLines, */ double orLat,
      double orLong,
      double tarLat,
      double tarLong) async {
    GoogleMapPolyLinesResponse? response =
        await APIRepo.getRoutesPolyLines(orLat, orLong, tarLat, tarLong);
    if (response == null) {
      log(AppLanguageTranslation
          .noPolylinesFoundForThisRouteTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      log(response.status);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingPolyLines(response);
  }

  void onSuccessRetrievingPolyLines(GoogleMapPolyLinesResponse response) {
    List<LatLng> pointLatLngs = [];
    for (var route in response.routes) {
      for (var leg in route.legs) {
        for (var step in leg.steps) {
          pointLatLngs.addAll(decodePolyline(step.polyline.points));
        }
      }
    }

    googleMapPolyLines.add(Polyline(
      polylineId: PolylineId('thePolyLine'),
      color: Colors.teal,
      width: 3,
      points: pointLatLngs,
    ));

    polyLinePoints.clear();
    for (var point in pointLatLngs) {
      polyLinePoints.add(
          LocationModel(latitude: point.latitude, longitude: point.longitude));
    }

    computeCentroid(polyLinePoints);
    update();
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  void computeCentroid(List<LocationModel> points) {
    double latitude = 0;
    double longitude = 0;
    LocationModel eastMost = LocationModel(latitude: 0, longitude: -180);
    LocationModel westMost = LocationModel(latitude: 0, longitude: 180);
    LocationModel northMost = LocationModel(latitude: -180, longitude: 0);
    LocationModel southMost = LocationModel(latitude: 180, longitude: 0);

    for (LocationModel point in points) {
      if (point.longitude > eastMost.longitude) {
        eastMost = point;
      }
      if (point.longitude < westMost.longitude) {
        westMost = point;
      }
      if (point.latitude > northMost.latitude) {
        northMost = point;
      }
      if (point.latitude < southMost.latitude) {
        southMost = point;
      }
    }
    log('EastMost: ${eastMost.longitude}\nWestMost: ${westMost.longitude}\nNorthMost: ${northMost.latitude}\nSouthMost: ${southMost.latitude}');
    latitude = ((northMost.latitude + southMost.latitude) / 2);
    longitude = ((eastMost.longitude + westMost.longitude) / 2);
    log('Centroid:\nLatitude: ${latitude}  Longitude: ${longitude}');

    final bound = boundsFromLatLngList([
      LatLng(eastMost.latitude, eastMost.longitude),
      LatLng(westMost.latitude, westMost.longitude),
      LatLng(southMost.latitude, southMost.longitude),
      LatLng(northMost.latitude, northMost.longitude)
    ]);
    /*
    pickupLocation!.latitude,
        pickupLocation!.longitude,
        dropLocation!.latitude,
        dropLocation!.longitude
    */
    if (bound != null) {
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
      update();
    }

    // return LatLng(latitude, longitude);
  }

  /*<----------- Complete trip button tap ----------->*/
  void onCompleteTripButtonTap() {
    completeTrip();
  }

  /*<----------- Cancle trip button tap ----------->*/
  void onCancelTripButtonTap() async {
    dynamic res =
        await Get.bottomSheet(const ChooseReasonCancelRideBottomSheet());
    if (res is String) {
      cancelReason = res;
      completeTrip(cancelReason: cancelReason);
    }
  }

  /*<----------- Start trip button tap ----------->*/
  void onStartTripButtonTap() async {
    isLoading = true;
    dynamic res = Get.bottomSheet(const SubmitOtpStartRideBottomSheet(),
        settings: RouteSettings(arguments: ridePrimaryDetails.id));
    isLoading = false;

    if (res is bool && res) {
      update();
    }
  }

  /*<----------- Complete trip  ----------->*/
  Future<void> completeTrip({String? cancelReason}) async {
    final Map<String, dynamic> requestBody = {
      '_id': ridePrimaryDetails.id,
      'status': 'completed'
    };
    if (cancelReason != null && cancelReason.isNotEmpty) {
      requestBody['status'] = 'cancelled';
      requestBody['cancel_reason'] = cancelReason;
    }
    isLoading = true;
    RawAPIResponse? response = await APIRepo.updateTripStatus(requestBody);
    isLoading = false;
    if (response == null) {
      Helper.showSnackBar(AppLanguageTranslation
          .noResponseForCompletingTripTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCompletingTrip(response);
  }

  onSuccessCompletingTrip(RawAPIResponse response) async {
    AppDialogs.showSuccessDialog(messageText: response.msg);
    // await Get.offAllNamed(AppPageNames.zoomDrawerScreen);
    // Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
    Helper.getBackToHomePage();
    update();
  }

  /*<----------- Complete trip  ----------->*/
  Future<void> reachedTrip({String? cancelReason}) async {
    final Map<String, dynamic> requestBody = {
      '_id': ridePrimaryDetails.id,
      'status': 'reached'
    };
    if (cancelReason != null && cancelReason.isNotEmpty) {
      requestBody['status'] = 'cancelled';
      requestBody['cancel_reason'] = cancelReason;
    }
    isLoading = true;
    RawAPIResponse? response = await APIRepo.updateTripStatus(requestBody);
    isLoading = false;
    if (response == null) {
      Helper.showSnackBar(AppLanguageTranslation
          .noResponseForCompletingTripTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessReachedTrip(response);
  }

  onSuccessReachedTrip(RawAPIResponse response) async {
    //  AppDialogs.showSuccessDialog(messageText: response.msg);
    getRideDetails();
    update();
  }

  LatLngBounds? boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) {
      return null;
    }
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  /*<----------- Fetch screen navigation argument----------->*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is RideDetailsData) {
      ridePrimaryDetails = argument;
      rideId = ridePrimaryDetails.id;
      status.value = ridePrimaryDetails.status;
      cancelReason = ridePrimaryDetails.cancelReason;
      pickupLocation = LocationModel(
          latitude: ridePrimaryDetails.from.location.lat,
          longitude: ridePrimaryDetails.from.location.lng,
          address: ridePrimaryDetails.from.address);
      dropLocation = LocationModel(
          latitude: ridePrimaryDetails.to.location.lat,
          longitude: ridePrimaryDetails.to.location.lng,
          address: ridePrimaryDetails.to.address);
      // startLocationUpdates(rideId);

      update();
    } else if (argument is RideHistoryDoc) {
      rideHistoryData = argument;
      rideId = rideHistoryData.id;
      status.value = rideHistoryData.status;
      cancelReason = rideHistoryData.cancelReason;
      pickupLocation = LocationModel(
          latitude: rideHistoryData.from.location.lat,
          longitude: rideHistoryData.from.location.lng,
          address: rideHistoryData.from.address);
      dropLocation = LocationModel(
          latitude: rideHistoryData.to.location.lat,
          longitude: rideHistoryData.to.location.lng,
          address: rideHistoryData.to.address);
      // startLocationUpdates(rideId);

      update();
    } else if (argument is AcceptedRequestScreenParameter) {
      screenParameter = argument;
      rideId = screenParameter?.rideId ?? '';
      pickupLocation =
          screenParameter?.selectedCarScreenParameter.pickupLocation;
      dropLocation = screenParameter?.selectedCarScreenParameter.dropLocation;
      // startLocationUpdates(rideId);

      update();
    }
  }

  /*<----------- Ride details from API ----------->*/
  Future<void> getRideDetails() async {
    RideDetailsResponse? response = await APIRepo.getRideDetails(rideId);
    if (response == null) {
      APIHelper.onError(response?.msg ??
          AppLanguageTranslation
              .noResponseFoundTryAgainTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRideDetails(response);
  }

  onSuccessRetrievingRideDetails(RideDetailsResponse response) {
    ridePrimaryDetails = response.data;
    status.value = ridePrimaryDetails.status;
    paymentId = ridePrimaryDetails.payment.transactionId;
    cancelReason = ridePrimaryDetails.cancelReason;
    pickupLocation = LocationModel(
        latitude: ridePrimaryDetails.from.location.lat,
        longitude: ridePrimaryDetails.from.location.lng,
        address: ridePrimaryDetails.from.address);
    dropLocation = LocationModel(
        latitude: ridePrimaryDetails.to.location.lat,
        longitude: ridePrimaryDetails.to.location.lng,
        address: ridePrimaryDetails.to.address);
    update();
  }
//======================

  void startRideStatusChecks() {
    /*  _rideStatusTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      checkRideStatus();
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

    /*  UserDetailsRide? userDetailsRide = response.data.ride;
    if (userDetailsRide.id.isNotEmpty) {
      rideId = userDetailsRide.id;
      update();
      startLocationUpdates(rideId);
    } */

    vehicleId = response.data.vehicle.id;
    update();
    startLocationUpdates(vehicleId);
  }

  void startLocationUpdates(String vehicleId) {
    _locationUpdateTimer ??= Timer.periodic(const Duration(seconds: 3), (_) {
      final shouldUpdateDriverLocation =
          ridePrimaryDetails.shouldUpdateDriverLocationFromStatus &&
              ridePrimaryDetails.id.isNotEmpty;
      // (ridePrimaryDetails.status == 'reached' || ridePrimaryDetails.status == 'completed' || ridePrimaryDetails.status == 'cancelled') == false;
      if (shouldUpdateDriverLocation) {
        log('shouldUpdateDriverLocation');
        updateDriverLocation(vehicleId);
      } else {
        log('shouldNOTUpdateDriverLocation');
      }
    });
    update();
  }

  Future<void> updateDriverLocation(String vehicleId) async {
    final LocationModel? locationModel = await getCurrentPosition();
    if (locationModel != null) {
      Map<String, dynamic> requestBody = {
        'vehicle': vehicleId,
        // 'online': false,
        'location': {
          'lat': locationModel.latitude,
          'lng': locationModel.longitude
        }
      };
      updateDriverStatus(requestBody);
      updateDriverMarker(
          LatLng(locationModel.latitude, locationModel.longitude));
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

  Future<void> getUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetUserDetails(response);
  }

  void onSuccessGetUserDetails(UserDetailsResponse response) {
    userDetailsData = response.data;
    rideId = response.data.rideStatus.id;
    status = response.data.status.obs;
    update();
  }

//=======================================
  StreamSubscription<RideHistoryDoc>? listen;
  StreamSubscription<PaymentSocketResponse>? listen1;
  dynamic onRideRequestStatusUpdate(dynamic data) async {
    if (data is RideHistoryDoc) {
      rideData = data;
      status = rideData.status.obs;
      update();
    }
  }

  dynamic onPaymentSuccess(PaymentSocketResponse data) async {
    rideId = data.ride;
    if (rideId.isNotEmpty) {
      getRideDetails();
    }
    update();
  }

/* <---- Initial state ----> */
  @override
  void onInit() async {
    _getScreenParameter();
    SocketController socketScreenController =
        Get.put<SocketController>(SocketController());

    listen ??= socketScreenController.rideDetails.listen((p0) {
      onRideRequestStatusUpdate(p0);
    });
    listen1 ??= socketScreenController.paymentSuccess.listen((p0) {
      onPaymentSuccess(p0);
    });
    _assignParameters();
    await createDriverCarIcon();

    getRideDetails();
    startRideStatusChecks();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1), // Adjust duration as needed
      vsync: this,
    );
    _animationController.addListener(_animateMarker);

    super.onInit();
  }

  @override
  void onClose() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
    onAsyncClose();
    super.onClose();
  }

  Future<void> onAsyncClose() async {
    await listen?.cancel();
    listen = null;
    await listen1?.cancel();
    listen1 = null;
  }

  LatLng? _previousPosition;
  LatLng? _targetPosition;
  BitmapDescriptor? driverCarIcon;
  double carRotation = 0.0;

  Future<BitmapDescriptor> _resizeImage(
      String assetPath, int width, int height) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  Future<void> createDriverCarIcon() async {
    final Uint8List? markerIcon = await getBytesFromAsset(
        AppAssetImages.carGPSImage, 80); // Make the car icon smaller
    if (markerIcon != null) {
      // driverCarIcon = BitmapDescriptor.bytes(markerIcon);
      driverCarIcon =
          await _resizeImage(AppAssetImages.locationIconImage, 50, 80);
      update();
    }
  }

  void updateDriverMarker(LatLng position) {
    googleMapMarkers
        .removeWhere((marker) => marker.markerId.value == 'driverMarker');

    if (driverCarIcon != null) {
      googleMapMarkers.add(
        Marker(
          markerId: MarkerId('driverMarker'),
          position: position,
          icon: driverCarIcon!,
          rotation: carRotation,
          anchor: Offset(1.5, 1.5),
        ),
      );
    }
  }

  void _animateMarker() {
    if (_latLngAnimation.value != null) {
      LatLng newPosition = _latLngAnimation.value;

      // Calculate the bearing for rotation
      carRotation = calculateBearing(_previousPosition!, newPosition);

      updateDriverMarker(newPosition);
      update();
    }
  }

/*   Future<void> updateDriverLocation(String vehicleId) async {
    final LocationModel? locationModel = await getCurrentPosition();
    if (locationModel != null) {
      Map<String, dynamic> requestBody = {
        'vehicle': vehicleId,
        'online': false,
        'location': {
          'lat': locationModel.latitude,
          'lng': locationModel.longitude
        }
      };
      updateDriverStatus(requestBody);

      // Set the previous and target positions for animation
      _previousPosition = _targetPosition;
      _targetPosition = LatLng(locationModel.latitude, locationModel.longitude);

      // Create a Tween for the LatLng animation
      final latTween = Tween<double>(
        begin: _previousPosition?.latitude ?? _targetPosition!.latitude,
        end: _targetPosition!.latitude,
      );
      final lngTween = Tween<double>(
        begin: _previousPosition?.longitude ?? _targetPosition!.longitude,
        end: _targetPosition!.longitude,
      );

      _latLngAnimation = Tween<LatLng>(
        begin: _previousPosition ?? _targetPosition!,
        end: _targetPosition!,
      ).animate(_animationController);

      // Start the animation
      _animationController.reset();
      _animationController.forward();
    }
  } */

  double calculateBearing(LatLng start, LatLng end) {
    double startLat = degreesToRadians(start.latitude);
    double startLng = degreesToRadians(start.longitude);
    double endLat = degreesToRadians(end.latitude);
    double endLng = degreesToRadians(end.longitude);

    double dLng = endLng - startLng;
    double y = math.sin(dLng) * math.cos(endLat);
    double x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(dLng);
    double bearing = radiansToDegrees(math.atan2(y, x));
    return (bearing + 360) % 360;
  }

  double degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
