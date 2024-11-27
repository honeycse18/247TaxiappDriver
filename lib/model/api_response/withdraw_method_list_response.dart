import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class WithdrawMethodListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<WithdrawMethodList> data;

  WithdrawMethodListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WithdrawMethodListResponse.fromJson(Map<String, dynamic> json) {
    return WithdrawMethodListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            WithdrawMethodList.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory WithdrawMethodListResponse.empty() => WithdrawMethodListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static WithdrawMethodListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethodListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethodListResponse.empty();
}

class WithdrawMethodList {
  String id;
  String name;
  String logo;
  List<String> requiredFields;
  DateTime createdAt;
  DateTime updatedAt;

  WithdrawMethodList({
    this.id = '',
    this.name = '',
    this.logo = '',
    required this.createdAt,
    required this.updatedAt,
    this.requiredFields = const [],
  });

  factory WithdrawMethodList.fromJson(Map<String, dynamic> json) =>
      WithdrawMethodList(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        requiredFields: APIHelper.getSafeListValue(json['required_fields'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'logo': logo,
        'required_fields': requiredFields,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory WithdrawMethodList.empty() => WithdrawMethodList(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static WithdrawMethodList getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethodList.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethodList.empty();
}
