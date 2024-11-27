import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SupportTextResponse {
  bool error;
  String msg;
  SupportTextItem data;

  SupportTextResponse({this.error = false, this.msg = '', required this.data});

  factory SupportTextResponse.fromJson(Map<String, dynamic> json) {
    return SupportTextResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SupportTextItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SupportTextResponse.empty() =>
      SupportTextResponse(data: SupportTextItem.empty());
  static SupportTextResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SupportTextResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SupportTextResponse.empty();
}

class SupportTextItem {
  String id;
  String title;
  String slug;
  String contentType;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  SupportTextItem({
    this.id = '',
    this.title = '',
    this.slug = '',
    this.contentType = '',
    this.content = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportTextItem.fromJson(Map<String, dynamic> json) =>
      SupportTextItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        title: APIHelper.getSafeStringValue(json['title']),
        slug: APIHelper.getSafeStringValue(json['slug']),
        contentType: APIHelper.getSafeStringValue(json['content_type']),
        content: APIHelper.getSafeStringValue(json['content']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'content_type': contentType,
        'content': content,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SupportTextItem.empty() => SupportTextItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static SupportTextItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SupportTextItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SupportTextItem.empty();
}
