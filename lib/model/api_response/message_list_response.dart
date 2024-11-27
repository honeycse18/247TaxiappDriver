import 'package:taxiappdriver/model/core_api_responses/paginated_data_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class MessageUserListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<MessageUserListItem> data;

  MessageUserListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory MessageUserListResponse.fromJson(Map<String, dynamic> json) {
    return MessageUserListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            MessageUserListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory MessageUserListResponse.empty() => MessageUserListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static MessageUserListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MessageUserListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MessageUserListResponse.empty();
}

class MessageUserListItem {
  String id;
  String message;
  DateTime createdAt;
  bool read;
  bool mine;
  User user;

  MessageUserListItem(
      {this.id = '',
      this.message = '',
      required this.createdAt,
      this.read = false,
      this.mine = false,
      required this.user});

  factory MessageUserListItem.fromJson(Map<String, dynamic> json) =>
      MessageUserListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        message: APIHelper.getSafeStringValue(json['message']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        read: APIHelper.getSafeBoolValue(json['read']),
        mine: APIHelper.getSafeBoolValue(json['mine']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'message': message,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'read': read,
        'mine': mine,
        'user': user.toJson(),
      };

  factory MessageUserListItem.empty() => MessageUserListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        user: User(),
      );
  static MessageUserListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MessageUserListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MessageUserListItem.empty();
}

class User {
  String uid;
  String name;
  String image;

  User({this.uid = '', this.name = '', this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}
