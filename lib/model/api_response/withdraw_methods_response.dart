import 'package:taxiappdriver/model/api_response/withdraw_method_list_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SavedWithdrawMethodsResponse {
  bool error;
  String msg;
  List<SavedWithdrawMethods> data;

  SavedWithdrawMethodsResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SavedWithdrawMethodsResponse.fromJson(Map<String, dynamic> json) {
    return SavedWithdrawMethodsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SavedWithdrawMethods.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static SavedWithdrawMethodsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedWithdrawMethodsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedWithdrawMethodsResponse();
}

class SavedWithdrawMethods {
  String id;
  String user;
  WithdrawMethodList type;
  String details;
  DateTime createdAt;
  DateTime updatedAt;

  SavedWithdrawMethods({
    this.id = '',
    this.user = '',
    required this.type,
    this.details = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedWithdrawMethods.fromJson(Map<String, dynamic> json) =>
      SavedWithdrawMethods(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        type: WithdrawMethodList.getAPIResponseObjectSafeValue(json['type']),
        details: APIHelper.getSafeStringValue(json['details']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'type': type.toJson(),
        'details': details,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SavedWithdrawMethods.empty() => SavedWithdrawMethods(
      createdAt: AppComponents.defaultUnsetDateTime,
      type: WithdrawMethodList.empty(),
      updatedAt: AppComponents.defaultUnsetDateTime);
  static SavedWithdrawMethods getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedWithdrawMethods.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedWithdrawMethods.empty();
}
