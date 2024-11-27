import 'package:taxiappdriver/model/screenParameters/location_model.dart';

class SelectLocationScreenParameters {
  String? screenTitle;
  bool? showCurrentLocationButton;
  LocationModel? locationModel;
  SelectLocationScreenParameters(
      {this.screenTitle, this.showCurrentLocationButton, this.locationModel});
}
