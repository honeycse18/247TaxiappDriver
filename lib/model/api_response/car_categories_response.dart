import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class CarCategoriesResponse {
  bool error;
  String msg;
  List<CarCategoriesCategory> data;

  CarCategoriesResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory CarCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CarCategoriesResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => CarCategoriesCategory.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CarCategoriesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarCategoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarCategoriesResponse();
}

class CarCategoriesCategory {
  String id;
  String uid;
  String name;

  CarCategoriesCategory({this.id = '', this.uid = '', this.name = ''});

  factory CarCategoriesCategory.fromJson(Map<String, dynamic> json) =>
      CarCategoriesCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static CarCategoriesCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarCategoriesCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarCategoriesCategory();
}
