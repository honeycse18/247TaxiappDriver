import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class PaymentSocketResponse {
  String status;
  String ride;

  PaymentSocketResponse({this.status='', this.ride=''});

  factory PaymentSocketResponse.fromJson(Map<String, dynamic> json) => PaymentSocketResponse(
        status: APIHelper.getSafeStringValue(json['status']),
        ride: APIHelper.getSafeStringValue(json['ride']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'ride': ride,
      };

      
          static PaymentSocketResponse getAPIResponseObjectSafeValue(
              dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? PaymentSocketResponse.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : PaymentSocketResponse();
      
}
