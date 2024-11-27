import 'package:taxiappdriver/model/api_response/chat_message_list_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';

class ChatMessageListSendResponse {
  bool error;
  String msg;
  ChatMessageListItem data;

  ChatMessageListSendResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ChatMessageListSendResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageListSendResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: ChatMessageListItem.getAPIResponseObjectSafeValue(json['data']));
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ChatMessageListSendResponse.empty() =>
      ChatMessageListSendResponse(data: ChatMessageListItem.empty());
  static ChatMessageListSendResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessageListSendResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatMessageListSendResponse.empty();
}
