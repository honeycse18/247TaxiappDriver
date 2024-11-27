import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class HomeScreenController extends GetxController {
  var selectedOption = ''.obs;
  final Set<Marker> googleMapMarkers = {};
  final Set<Polyline> googleMapPolylines = {};

  GoogleMapController? googleMapController;
  LocationModel? selectedLocation;
  TextEditingController locationTextEditingController = TextEditingController();
  final String markerID = 'markerID';
  bool mapMarked = false;
  late Location location;
  final String driverMarkerID = 'driverID';
  BitmapDescriptor? myCarIcon;
  DriverVehicle vehicleStatusChange = DriverVehicle.empty();
  bool addVehicle = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    update();
    // googleMapControllerCompleter.complete(controller);
  }

  void onGoogleMapTap(LatLng latLng) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    // panelController.open();
  }

  Rx<LatLng> userLocation = Rx<LatLng>(LatLng(0.0, 0.0));

  UserDetailsData userDetails = UserDetailsData.empty();

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

/*   void createCarsLocationIcon() async {
    myCarIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(150, 150)),
        AppAssetImages.carGPSImage);
    update();
  } */
  void createCarsLocationIcon() async {
    myCarIcon = await _resizeImage(
        AppAssetImages.carGPSImage, 40, 80); // Adjust the size as needed
    update();
  }

  Future<void> getCurrentLocation() async {
    try {
      var currentLocation = await location.getLocation();
      LatLng latLng = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
      userLocation.value = latLng;
      _focusLocation(
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          showRiderLocation: true);
      final double zoomLevel = await googleMapController!.getZoomLevel();
      double newZoomLevel = zoomLevel < 15 ? 15 : zoomLevel;
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: newZoomLevel)));
      AppSingleton.instance.defaultCameraPosition =
          CameraPosition(target: latLng, zoom: newZoomLevel);
      log('${userLocation.value}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _focusLocation(
      {required double latitude,
      required double longitude,
      bool showRiderLocation = false}) async {
    final latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    if (showRiderLocation) {
      _addTapMarker(latLng);
    } else {
      _addMarker(latLng);
    }
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    update();
  }

  Future<void> _addTapMarker(LatLng latLng) async {
    // BitmapDescriptor? gpsIcon;
    final context = Get.context;
    if (context != null) {
      /* final ImageConfiguration config = createLocalImageConfiguration(context);
      gpsIcon = await BitmapDescriptor.fromAssetImage(
        config,
        AppAssetImages.carGPSImage,
      ); */
    }
    googleMapMarkers.add(Marker(
        markerId: MarkerId(driverMarkerID),
        anchor: const Offset(0.5, 0.5),
        position: latLng,
        icon: myCarIcon!));
  }

  Future<void> _addMarker(LatLng latLng) async {
    final context = Get.context;
    if (context != null) {}
    googleMapMarkers.add(Marker(
        markerId: MarkerId(markerID), position: latLng, icon: myCarIcon!));
  }

  Future<void> getLoggedInUserDetails() async {
    isLoading = true;
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) {
    userDetails = response.data;
    update();
  }

  Future<void> _requestPermission() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
    }
  }

  /*<-----------Get socket response for new ride request ----------->*/
  dynamic onVehicleChangeRequest(dynamic data) {
    log('data socket');
    DriverVehicle? response = DriverVehicle.empty();
    if (data is DriverVehicle) {
      response = data;
      update();
    }
    log(response.toJson().toString());
    if (response.id.isNotEmpty) {
      vehicleStatusChange = response;
      update();
      // AppDialogs.showSuccessDialog(messageText: 'Ride Request Accepted');
      if (response.status == 'approved') {
        addVehicle = true;
        isCarApproved();
        update();

        AppDialogs.showSuccessDialog(
            messageText:
                'Your vehicle is approved. You can start your ride now');
        onInitFunction();
        update();
      } else if (response.status == 'suspended') {
        AppDialogs.showErrorDialog(messageText: 'Your vehicle is Suspended.');
        onInitFunction();
        update();
      }

      /* Get.bottomSheet(const ReceiveRideBottomSheetScreen(),
          isDismissible: false,
          enableDrag: false,
          isScrollControlled: false,
          settings: RouteSettings(arguments: rideShareRequest)); */
    }
    update();
  }

  bool isCarApproved() => userDetails.vehicle.status == 'approved';
  bool isProfileApproved() => userDetails.status == 'approved';

  bool isProfileComplete() {
    return (userDetails.role == 'driver' &&
            userDetails.badgeNumber.isNotEmpty &&
            userDetails.dbsNumber.isNotEmpty &&
            userDetails.driverNi
                .isNotEmpty && /* 
            userDetails.address != '' &&
            userDetails.driverNiNumber != '' &&
            userDetails.drivingLicense.isNotEmpty &&
            userDetails.enhanceDbs != '' && */
            // userDetails.image != '' &&
            userDetails.taxiDriverBadge.isNotEmpty &&
            userDetails.idCard.isNotEmpty)
        ? true
        : false;
  }

  bool isVehicleComplete() {
    return userDetails.vehicle.id.isNotEmpty;
  }

  StreamSubscription<DriverVehicle>? listen6;

  Future<void> onInitFunction() async {
    location = Location();
    await getLoggedInUserDetails();
    _requestPermission();
    createCarsLocationIcon();
    isCarApproved();
    isProfileComplete();
  }

  @override
  void onInit() async {
    location = Location();
    await getLoggedInUserDetails();

    SocketController socketController =
        Get.put<SocketController>(SocketController());
    listen6 ??= socketController.vehicleStatusChange.listen((p0) {
      onVehicleChangeRequest(p0);
    }, cancelOnError: false);
    _requestPermission();
    createCarsLocationIcon();
    isCarApproved();
    isProfileComplete();
    super.onInit();
  }

  @override
  void onClose() {
    onAsyncInit();
    super.onClose();
  }

  Future<void> onAsyncInit() async {
    await listen6?.cancel();
    listen6 = null;
  }
}
