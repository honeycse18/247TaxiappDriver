import 'package:taxiappdriver/model/screenParameters/select_car_screen_parameter.dart';

class AcceptedRequestScreenParameter {
  SelectCarScreenParameter selectedCarScreenParameter;
  String rideId;
  AcceptedRequestScreenParameter(
      {required this.selectedCarScreenParameter, required this.rideId});
}

class AddWalletScreenParameter {
  List<String> neededParams;
  String type;
  AddWalletScreenParameter({required this.neededParams, required this.type});
}
