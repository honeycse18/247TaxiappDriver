import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class LoginResponse {
  bool error;
  String msg;
  LoginData data;

  LoginResponse({this.error = false, this.msg = '', required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: LoginData.getAPIResponseObjectSafeValue(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory LoginResponse.empty() => LoginResponse(
        data: LoginData(),
      );
  static LoginResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : LoginResponse.empty();
}

class LoginData {
  String token;
  String role;

  LoginData({this.token = '', this.role = ''});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: APIHelper.getSafeStringValue(json['token']),
        role: APIHelper.getSafeStringValue(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'role': role,
      };

  static LoginData getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LoginData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : LoginData();
}
