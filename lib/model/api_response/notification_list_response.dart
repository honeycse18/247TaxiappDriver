import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class NotificationListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<NotificationListItem> data;

  NotificationListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            NotificationListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory NotificationListResponse.empty() =>
      NotificationListResponse(data: PaginatedDataResponse.empty());
  static NotificationListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NotificationListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NotificationListResponse.empty();
}

class NotificationListItem {
  String id;
  String user;
  String action;
  String title;
  String message;
  String objectId;
  bool read;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationListItem({
    this.id = '',
    this.user = '',
    this.action = '',
    this.title = '',
    this.message = '',
    this.objectId = '',
    this.read = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationListItem.fromJson(Map<String, dynamic> json) =>
      NotificationListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        action: APIHelper.getSafeStringValue(json['action']),
        title: APIHelper.getSafeStringValue(json['title']),
        message: APIHelper.getSafeStringValue(json['message']),
        objectId: APIHelper.getSafeStringValue(json['ObjectId']),
        read: APIHelper.getSafeBoolValue(json['read']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'action': action,
        'title': title,
        'message': message,
        'ObjectId': objectId,
        'read': read,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory NotificationListItem.empty() => NotificationListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static NotificationListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NotificationListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NotificationListItem.empty();
}
