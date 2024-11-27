import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:taxiappdriver/model/screenParameters/location_model.dart';
import 'package:taxiappdriver/model/screenParameters/select_screen_parameters.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class SelectLocationScreenController extends GetxController {
  bool mapMarked = false;
  bool showCurrentLocation = true;
  String screenTitle = '';
  Position? _currentPosition;
  bool keyBoardHidden = true;

  GoogleMapController? googleMapController;
  TextEditingController locationTextEditingController = TextEditingController();
  final TextEditingController searchTextController = TextEditingController();
  FocusNode focusSearchBox = FocusNode();
  final String markerID = 'markerID';
  LocationModel? selectedLocation;
  final Set<Marker> googleMapMarkers = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<Prediction> _predictionList = [];

  Future<LatLng> fetchLocation(String placeId) async {
    const apiKey =
        AppConstants.googleAPIKey; // Replace with your Google API Key
    final location = await getLatLngFromPlaceId(placeId, apiKey);
    log('Latitude: ${location['latitude']}, Longitude: ${location['longitude']}');
    return LatLng(location['latitude'], location['longitude']);
  }

  Future<Map<String, dynamic>> getLatLngFromPlaceId(
      String placeId, String apiKey) async {
    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      double lat = location['lat'];
      double lng = location['lng'];
      return {'latitude': lat, 'longitude': lng};
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<http.Response> getLocationData(String text) async {
    http.Response response;

    response = await http.get(
      Uri.parse(
          "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=${AppConstants.googleAPIKey}&input=$text"),
      headers: {"Content-Type": "application/json"},
    );
    //  let response = try await Networking().GetRaw(to: "https://maps.googleapis.com/maps/api/place/queryautocomplete/json", params: ["key": mapKey, "input": text])

    log(response.toString());
    return response;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String? text) async {
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      log('my status is ${data["status"]}');
      if (data['status'] == 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        log('No predictions found!');
      }
    }
    return _predictionList;
  }

  void setLocation(String placeID, String description,
      GoogleMapController? mapController) async {
    locationTextEditingController.text = description;
    googleMapController = mapController;
    LatLng latLng = await fetchLocation(placeID);
    update();
    onGoogleMapTap(latLng, address: description);
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;

    if (selectedLocation != null) {
      onGoogleMapTap(
          LatLng(selectedLocation?.latitude ?? 0,
              selectedLocation?.longitude ?? 0),
          address: selectedLocation?.address ?? 'No Location');
    }
  }

  void onGoogleMapTap(LatLng latLng, {String? address}) async {
    _focusLocation(latitude: latLng.latitude, longitude: latLng.longitude);
    if (address == null) {
      address = await latLngToAddress(latLng.latitude, latLng.longitude);
    } else {
      address = address;
    }
    locationTextEditingController.text = address;
    update();
    selectedLocation = LocationModel(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        address: address);
  }

  Future<void> _focusLocation(
      {required double latitude, required double longitude}) async {
    final LatLng latLng = LatLng(latitude, longitude);
    if (googleMapController == null) {
      return;
    }
    _addMarker(latLng);
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        AppSingleton.instance.defaultCameraPosition =
            CameraPosition(target: latLng, zoom: zoomLevel)));
    update();
  }

  Future<void> _addMarker(LatLng latLng) async {
/*     googleMapMarkers.removeWhere((element) {
      return element.markerId.value != riderMarkerID;
    }); */
    googleMapMarkers
        .add(Marker(markerId: MarkerId(markerID), position: latLng));
    mapMarked = true;
    update();
  }

  Future<String> latLngToAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      final placemark = placemarks.firstOrNull;
      if (placemark == null) {
        return '';
      }
      String? street = placemark.street;
      String? locality = placemark.locality;
      String? country = placemark.country;
      return '$street, $locality, $country';
    } catch (e) {
      log(e.toString());
      return 'Null Address';
    }
  }

  void onConfirmLocationButtonTap() async {
    isLoading = true;
    final result = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      titleText: AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
      messageText:
          AppLanguageTranslation.confirmLocationTransKey.toCurrentLanguage,
      onYesTap: () async {
        isLoading = false;

        Get.back(result: true);
      },
    );
    if (result is bool && result) {
      isLoading = false;

      Get.back(result: selectedLocation);
    }
  }

  void getCurrentPosition(BuildContext context) {
    _getCurrentPosition(context);
  }

  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) {
      log('No permission acquired!');
      return;
    }
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      locationTextEditingController.text = await latLngToAddress(
          _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);
      _focusLocation(
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      selectedLocation = LocationModel(
          address: locationTextEditingController.text,
          latitude: _currentPosition?.latitude ?? 0,
          longitude: _currentPosition?.longitude ?? 0);
      selectedLocation = selectedLocation;
      update();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location Service Disabled', 'Please enable location service',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
            'Location Service Disabled', 'Please enable location service',
            snackPosition: SnackPosition.TOP);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location Service Disabled',
          'Location permissions are permanently Disabled, we cannot request permissions.',
          snackPosition: SnackPosition.TOP);
      return false;
    }
    return true;
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SelectLocationScreenParameters) {
      showCurrentLocation = params.showCurrentLocationButton ?? true;
      screenTitle = params.screenTitle ?? 'Select Address';
      selectedLocation =
          params.locationModel?.latitude != 0 ? params.locationModel : null;

      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    // searchTextController.addListener(() {
    //   log(searchTextController.text);
    // });
    super.onInit();
  }

  @override
  void onClose() {
    googleMapMarkers.clear();
    selectedLocation = null;
    googleMapController?.dispose();
    locationTextEditingController.dispose();

    super.onClose();
  }
}
