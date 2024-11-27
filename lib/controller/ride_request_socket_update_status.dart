import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class RideRequestUpdateSocketResponse {
  String status;
  String ride;
  String request;

  RideRequestUpdateSocketResponse(
      {this.status = '', this.ride = '', this.request = ''});

  factory RideRequestUpdateSocketResponse.fromJson(Map<String, dynamic> json) {
    return RideRequestUpdateSocketResponse(
      status: APIHelper.getSafeStringValue(json['status']),
      ride: APIHelper.getSafeStringValue(json['ride']),
      request: APIHelper.getSafeStringValue(json['request']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'ride': ride,
        'request': request,
      };

  static RideRequestUpdateSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestUpdateSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestUpdateSocketResponse();
}
