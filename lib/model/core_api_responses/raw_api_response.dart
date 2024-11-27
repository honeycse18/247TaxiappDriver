import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class RawAPIResponse {
  bool error;
  String msg;
  dynamic data;

  RawAPIResponse({this.error = false, this.msg = '', this.data});

  factory RawAPIResponse.fromJson(Map<String, dynamic> json) {
    return RawAPIResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data,
      };

  static RawAPIResponse getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RawAPIResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RawAPIResponse();
}
