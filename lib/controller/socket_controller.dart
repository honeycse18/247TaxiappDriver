import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:taxiappdriver/controller/ride_request_socket_update_status.dart';
import 'package:taxiappdriver/model/api_response/chat_message_list_response.dart';
import 'package:taxiappdriver/model/api_response/payment_socket.dart';
import 'package:taxiappdriver/model/api_response/ride_details_response.dart';
import 'package:taxiappdriver/model/api_response/ride_history_response.dart';
import 'package:taxiappdriver/model/api_response/ride_share_request_socket_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class SocketController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  Rx<RideShareRequestSocketResponse> rideShareRequest =
      RideShareRequestSocketResponse.empty().obs;
  Rx<DriverVehicle> vehicleStatusChange = DriverVehicle.empty().obs;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideHistoryDoc> rideDetails = RideHistoryDoc.empty().obs;
  Rx<PaymentSocketResponse> paymentSuccess = PaymentSocketResponse().obs;

  /*<-----------Socket initialize ----------->*/
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  /*<-----------Get socket response for ride request status ----------->*/
  dynamic onNewRideRequest(dynamic data) {
    log('data socket');
    final RideShareRequestSocketResponse mapData =
        RideShareRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    rideShareRequest.value = mapData;
    update();
  }

  /*<-----------Get socket response for ride request status ----------->*/
  dynamic onVehicleStatusChange(dynamic data) {
    log('data socket');
    final DriverVehicle mapData =
        DriverVehicle.getAPIResponseObjectSafeValue(data);
    vehicleStatusChange.value = mapData;
    update();
  }

  /*<-----------Get socket response for ride request status update ----------->*/
  dynamic onRideRequestUpdate(dynamic data) {
    log('request is updated');
    RideRequestUpdateSocketResponse response =
        RideRequestUpdateSocketResponse.getAPIResponseObjectSafeValue(data);

    log(response.toJson().toString());
    if (response.status == 'rejected') {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      // AppDialogs.showErrorDialog( messageText: AppLanguageTranslation .requestHasBeenCancelledByUserTranskey.toCurrentLanguage);
    }
  }

  dynamic onRideUpdate(dynamic data) {
    log('ride is updated');
    RideHistoryDoc response =
        RideHistoryDoc.getAPIResponseObjectSafeValue(data);
    rideDetails.value = response;
    if (response.status == 'cancelled') {
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      // AppDialogs.showErrorDialog( messageText: '${AppLanguageTranslation.rideHasBeenCancelledReasonTranskey.toCurrentLanguage} ${response.cancelReason}');
    }
  }

/* 
  /*<-----------Get socket response for new messages ----------->*/
  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

/*<-----------Get socket response for update messages ----------->*/
  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  } */
  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

  dynamic onPaymentProcess(dynamic data) {
    log(data.toString());
    String staus = data['status'];
    if (staus == 'success') {
      paymentSuccess.value = PaymentSocketResponse(
        status: data['status'],
        ride: data['ride'],
      );
      AppDialogs.showSuccessDialog(
          messageText: 'You have successfully received payment.');
      update();
    } else {
      AppDialogs.showErrorDialog(messageText: 'Payment failed.');
    }
    update();
  }

  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  void initSocket() {
/*     IO.Socket socket = IO.io(
        AppConstants.appBaseURL,
        IO.OptionBuilder()
            // .setAuth(Helper.getAuthHeaderMap())
            .setAuth(<String, String>{
          'token': Helper.getUserToken()
        }).setTransports(['websocket']) // for Flutter or Dart VM
            .build()); */
    if (socket.connected == false) {
      socket = socket.connect();
    }
    socket.on('vehicle_status_update', onVehicleStatusChange);
    socket.on('new_ride', onNewRideRequest);
    socket.on('ride_request_status', onRideRequestUpdate);
    socket.on('ride_update', onRideUpdate);
    socket.on('new_message', onNewMessages);
    socket.on('update_message', onUpdateMessages);
    socket.on('new_admin_message', onNewMessages);
    socket.on('payment_success', onPaymentProcess);
    socket.on('update_admin_message', onUpdateMessages);

    socket.onConnect((data) {
      log('data');
      // socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
    });
    /* socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err)); */
    socket.onConnectError((data) {
      log('data'.toString());
    });
    socket.onConnecting((data) {
      log('data'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data');
    });
    socket.onReconnectAttempt((data) {
      log('data');
    });
    socket.onReconnect((data) {
      log('data');
    });
    socket.onReconnectFailed((data) {
      log('data');
    });
    socket.onReconnectError((data) {
      log('data');
    });
    socket.onError((data) {
      log('data');
    });
    socket.onDisconnect((data) {
      log('data');
    });
    socket.onPing((data) {
      log('data');
    });
    socket.onPong((data) {
      log('data');
    });
  }

  void disposeSocket() {
    if (socket.connected) {
      socket.disconnect();
    }
    socket.dispose();
    super.onClose();
  }

  /* <---- Initial state ----> */
  @override
  void onInit() {
    if (!socket.connected) {
      // initSocket();
    }
    super.onInit();
  }

  @override
  void onClose() {
    // disposeSocket();
  }
}
