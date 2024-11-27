

import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class SocialGoogleLoginResponse {
  bool error;
  String msg;
  String token;
  SocialGoogleLoginData data;

  SocialGoogleLoginResponse(
      {this.error = false, this.msg = '', this.token = '', required this.data});

  factory SocialGoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    return SocialGoogleLoginResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      token: APIHelper.getSafeStringValue(json['token']),
      data: SocialGoogleLoginData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'token': token,
        'data': data.toJson(),
      };

  factory SocialGoogleLoginResponse.empty() =>
      SocialGoogleLoginResponse(data: SocialGoogleLoginData());

  static SocialGoogleLoginResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SocialGoogleLoginResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SocialGoogleLoginResponse.empty();
}

class SocialGoogleLoginData {
  String id;
  String name;
  String email;
  String image;
  String phone;
  String role;
  String authType;
  String token;

  SocialGoogleLoginData({
    this.id = '',
    this.name = '',
    this.email = '',
    this.image = '',
    this.phone = '',
    this.role = '',
    this.authType = '',
    this.token = '',
  });

  factory SocialGoogleLoginData.fromJson(Map<String, dynamic> json) =>
      SocialGoogleLoginData(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        role: APIHelper.getSafeStringValue(json['role']),
        authType: APIHelper.getSafeStringValue(json['auth_type']),
        token: APIHelper.getSafeStringValue(json['token']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'image': image,
        'phone': phone,
        'role': role,
        'auth_type': authType,
        'token': token,
      };

  static SocialGoogleLoginData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SocialGoogleLoginData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SocialGoogleLoginData();
}
