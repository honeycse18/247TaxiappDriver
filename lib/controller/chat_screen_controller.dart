import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/chat_message_list_demo_response.dart';
import 'package:taxiappdriver/model/api_response/chat_message_list_response.dart';
import 'package:taxiappdriver/model/api_response/get_user_data_response.dart';
import 'package:taxiappdriver/model/api_response/message_list_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class ChatScreenController extends GetxController {
  RxBool isTooltipShown = false.obs;
  UserDetailsData userDetailsData = UserDetailsData.empty();
  GetUserData getUser = GetUserData();

  void showTooltip() {
    isTooltipShown.value = true;
  }

  void hideTooltip() {
    isTooltipShown.value = false;
  }

  TextEditingController messageController = TextEditingController();
  ScrollController chatScrollController = ScrollController();
  MessageUserListItem chatUser = MessageUserListItem.empty();
  ChatMessageListItem chatMessages = ChatMessageListItem.empty();
  String chatUserId = '';
  // List<ChatMessageListItem> chaMessagetList = [];

  PagingController<int, ChatMessageListItem> chatMessagePagingController =
      PagingController(firstPageKey: 1);

  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());
  StreamSubscription<ChatMessageListItem>? newMessageListener;
  StreamSubscription<ChatMessageListItem>? updatedMessageListener;
  /* ChatMessageListItem? previousChatMessage(int currentIndex) {
    if (currentIndex == 0) {
      return null;
    }
    final previousIndex = currentIndex - 1;
    try {
      return chaMessagetList[previousIndex];
    } catch (e) {
      return null;
    }
  } */
  //------------Get Method----------------

  Future<void> getIdUserDetails(String id) async {
    GetUserDataResponse? response = await APIRepo.getIdUserDetails(id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetIdUsers(response);
  }

  _onSuccessGetIdUsers(GetUserDataResponse response) {
    getUser = response.data;
    update();
  }

  Future<void> getUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) {
    userDetailsData = response.data;
    update();
  }
  //------------Get Method----------------

  Future<void> getChatMessageList(int currentPageNumber, String id) async {
    ChatMessageListResponse? response =
        await APIRepo.getChatMessageList(currentPageNumber, id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(ChatMessageListResponse response) {
    final isLastPage = !response.data.hasNextPage;

    if (response.data.page == 1 && response.data.docs.firstOrNull != null) {
      readMessage(response.data.docs.firstOrNull!.id);
    }
    if (isLastPage) {
      chatMessagePagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    chatMessagePagingController.appendPage(response.data.docs, nextPageNumber);
  }

  //------------post method---------------
  Future<void> sendMessage(String id) async {
    Map<String, dynamic> requestBody = {
      'to': id,
      'message': messageController.text
    };
    messageController.clear();
    ChatMessageListSendResponse? response =
        await APIRepo.sendMessage(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessSendMessage(response);
  }

  _onSucessSendMessage(ChatMessageListSendResponse response) {
    chatMessagePagingController.value.itemList?.insert(0, response.data);
    update();
  }

  //------------post method---------------
  Future<void> readMessage(String id) async {
    Map<String, dynamic> requestBody = {'_id': id, 'read': true};
    messageController.clear();
    RawAPIResponse? response = await APIRepo.readMessage(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessReadMessage(response);
  }

  _onSucessReadMessage(RawAPIResponse response) {
    log(response.msg);
  }

  /* String generateID() {
    final objectId = ObjectId();
    return objectId.hexString;
  } */
  /* dynamic onLoadMessages(dynamic data) {
    log('data');
    chatList.insertAll(
        0, ChatMessageListItem.getAPIResponseObjectSafeValue(data));
    update();
    Helper.scrollToStart(chatScrollController);
  } */

  bool isMyChatMessage(ChatMessageListItem chatMessages) {
    final myID = Helper.getUser().id;
    return chatMessages.from.id == myID;
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      chatUserId = argument;
      update();
    }
  }

  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    /*  chaMessagetList?.insertAll(
        0, ChatMessageListResponse.getAPIResponseObjectSafeValue(data)); */
    // final message = ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    chatMessagePagingController.value.itemList?.insert(0, data);
    update();
    // chatMessagePagingController.refresh();
  }

  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
  }

  @override
  void onInit() {
    _getScreenParameter();
    SocketController socketController = Get.find<SocketController>();

    newMessageListener ??= socketController.newMessageData.listen((p0) {
      onNewMessages(p0);
      // readMessage(p0.id);
    });
    updatedMessageListener ??= socketController.updatedMessageData.listen((p0) {
      onUpdateMessages(p0);
      // readMessage(p0.id);
    });
    // TODO: implement onInit
    chatMessagePagingController.addPageRequestListener((pageKey) {
      getChatMessageList(pageKey, chatUserId);
    });
    // readMessage(chatMessagePagingController.itemList?);

    getIdUserDetails(chatUserId);

    super.onInit();
  }

  /* @override
  void onClose() {
    // TODO: implement onClose
    // socket.disconnect();
    // socket.dispose();
    super.onClose();
  } */

  @override
  void onClose() {
    onAsyncClose();
    super.onClose();
  }

  Future<void> onAsyncClose() async {
    await newMessageListener?.cancel();
    newMessageListener = null;
    await updatedMessageListener?.cancel();
    updatedMessageListener = null;
  }
}
