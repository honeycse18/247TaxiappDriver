import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class CarBrandModelResponse {
  bool error;
  String msg;
  List<ModelElement> data;

  CarBrandModelResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory CarBrandModelResponse.fromJson(Map<String, dynamic> json) {
    return CarBrandModelResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => ModelElement.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CarBrandModelResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarBrandModelResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarBrandModelResponse();
}

class ModelElement {
  String id;
  String name;
  String image;

  ModelElement({this.id = '', this.name = '', this.image = ''});

  factory ModelElement.fromJson(Map<String, dynamic> json) => ModelElement(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static ModelElement getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ModelElement.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ModelElement();
}
