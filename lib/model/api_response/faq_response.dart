import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class FaqResponse {
  bool error;
  String msg;
  PaginatedDataResponse<FaqItems> data;

  FaqResponse({this.error = false, this.msg = '', required this.data});

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
          json['data'],
          docFromJson: (data) => FaqItems.getAPIResponseObjectSafeValue(data),
        ),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory FaqResponse.empty() => FaqResponse(
        data: PaginatedDataResponse.empty(),
      );
  static FaqResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FaqResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : FaqResponse.empty();
}

class FaqItems {
  String id;
  String question;
  String answer;
  DateTime createdAt;
  DateTime updatedAt;

  FaqItems({
    this.id = '',
    this.question = '',
    this.answer = '',
    required this.updatedAt,
    required this.createdAt,
  });

  factory FaqItems.fromJson(Map<String, dynamic> json) => FaqItems(
        id: APIHelper.getSafeStringValue(json['_id']),
        question: APIHelper.getSafeStringValue(json['question']),
        answer: APIHelper.getSafeStringValue(json['answer']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'question': question,
        'answer': answer,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory FaqItems.empty() => FaqItems(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static FaqItems getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FaqItems.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : FaqItems.empty();
}
