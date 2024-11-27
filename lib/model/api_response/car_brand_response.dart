import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class CarBrandResponse {
  bool error;
  String msg;
  List<BrandElement> data;

  CarBrandResponse({this.error = false, this.msg = '', this.data = const []});

  factory CarBrandResponse.fromJson(Map<String, dynamic> json) {
    return CarBrandResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => BrandElement.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CarBrandResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarBrandResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarBrandResponse();
}

class BrandElement {
  String id;
  String name;
  String image;

  BrandElement({this.id = '', this.name = '', this.image = ''});

  factory BrandElement.fromJson(Map<String, dynamic> json) => BrandElement(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static BrandElement getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BrandElement.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : BrandElement();
}
