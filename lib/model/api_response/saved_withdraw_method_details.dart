import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SavedWithdrawMethodDetailsResponse {
  bool error;
  String msg;
  SavedWithdrawMethods data;

  SavedWithdrawMethodDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SavedWithdrawMethodDetailsResponse.fromJson(
      Map<String, dynamic> json) {
    return SavedWithdrawMethodDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SavedWithdrawMethods.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SavedWithdrawMethodDetailsResponse.empty() =>
      SavedWithdrawMethodDetailsResponse(
        data: SavedWithdrawMethods.empty(),
      );
  static SavedWithdrawMethodDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedWithdrawMethodDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedWithdrawMethodDetailsResponse.empty();
}
