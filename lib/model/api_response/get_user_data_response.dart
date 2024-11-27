import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class GetUserDataResponse {
  bool error;
  String msg;
  GetUserData data;

  GetUserDataResponse({this.error = false, this.msg = '', required this.data});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetUserDataResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: GetUserData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory GetUserDataResponse.empty() => GetUserDataResponse(
        data: GetUserData(),
      );
  static GetUserDataResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetUserDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetUserDataResponse.empty();
}

class GetUserData {
  String id;
  String uid;
  String name;
  String email;
  String image;
  String role;

  GetUserData(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.email = '',
      this.image = '',
      this.role = ''});

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
        role: APIHelper.getSafeStringValue(json['role']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
        'role': role,
      };

  static GetUserData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetUserData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : GetUserData();
}
