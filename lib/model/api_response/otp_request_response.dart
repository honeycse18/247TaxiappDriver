import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class OtpRequestResponse {
  bool error;
  String msg;
  String data;

  OtpRequestResponse({this.error = false, this.msg = '', this.data = ''});

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) {
    return OtpRequestResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeStringValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data,
      };

  static OtpRequestResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OtpRequestResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OtpRequestResponse();
}
