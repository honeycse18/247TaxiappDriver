import 'package:taxiappdriver/model/screenParameters/location_model.dart';

class SavedLocationScreenParameter {
  String id;
  LocationModel locationModel;
  String addressType;
  String? othersText;
  SavedLocationScreenParameter(
      {this.id = '',
      required this.locationModel,
      required this.addressType,
      this.othersText = ''});
}
