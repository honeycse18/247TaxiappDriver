import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class FindAccountResponse {
  bool error;
  String msg;
  FindAccountData data;

  FindAccountResponse({this.error = false, this.msg = '', required this.data});

  factory FindAccountResponse.fromJson(Map<String, dynamic> json) {
    return FindAccountResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: FindAccountData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory FindAccountResponse.empty() => FindAccountResponse(
        data: FindAccountData(),
      );
  static FindAccountResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FindAccountResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FindAccountResponse.empty();
}

class FindAccountData {
  bool account;
  String role;

  FindAccountData({this.account = false, this.role = ''});

  factory FindAccountData.fromJson(Map<String, dynamic> json) =>
      FindAccountData(
        account: APIHelper.getSafeBoolValue(json['account']),
        role: APIHelper.getSafeStringValue(json['role']),
      );

  Map<String, dynamic> toJson() => {
        'account': account,
        'role': role,
      };

  static FindAccountData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FindAccountData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FindAccountData();
}
