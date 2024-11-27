import 'package:app_links/app_links.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/socket_controller.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class ZoomDrawerScreenController extends GetxController {
  late final AppLinks _appLinks;

  final zoomDrawerController = ZoomDrawerController();
  SocketController? socketController;
  UserDetailsData userDetails = UserDetailsData.empty();

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) {
    userDetails = response.data;
    update();
  }

  void _initDeepLinkListener() async {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        if (uri.path == '/add-money-driver') {
          Get.toNamed(AppPageNames.zoomDrawerScreen);
        }
        if (uri.path == '/subscription') {
          Get.toNamed(AppPageNames.subscriptionScreen);
          AppDialogs.showSuccessDialog(
              messageText: 'your Subscription Added Successfully');
        }
      }
    });
  }

  @override
  void onInit() {
    try {
      // socketController = Get.find<SocketController>();
      socketController = Get.find<SocketController>();
    } catch (e) {
      socketController = Get.put<SocketController>(SocketController());
    }
    socketController?.initSocket();
    _appLinks = AppLinks();
    _initDeepLinkListener();

    super.onInit();
  }

  @override
  void onClose() {
    socketController?.disposeSocket();
    super.onClose();
  }
}
