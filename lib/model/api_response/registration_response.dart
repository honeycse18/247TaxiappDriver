import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class RegistrationResponse {
  bool error;
  String msg;
  RegistrationData data;

  RegistrationResponse({this.error = false, this.msg = '', required this.data});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: RegistrationData.getAPIResponseObjectSafeValue(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RegistrationResponse.empty() => RegistrationResponse(
        data: RegistrationData(),
      );
  static RegistrationResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RegistrationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RegistrationResponse.empty();
}

class RegistrationData {
  String token;
  String role;

  RegistrationData({this.token = '', this.role = ''});

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        token: APIHelper.getSafeStringValue(json['token']),
        role: APIHelper.getSafeStringValue(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
      };

  static RegistrationData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RegistrationData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RegistrationData();
}
