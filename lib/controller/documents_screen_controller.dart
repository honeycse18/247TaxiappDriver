import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class DocumentsScreenController extends GetxController {
  UserDetailsData userDetails = UserDetailsData.empty();
  final GlobalKey<FormState> documentFormKey = GlobalKey<FormState>();

  TextEditingController licenseNumberEditingController =
      TextEditingController();
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

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is UserDetailsData) {
      userDetails = params;
      getLoggedInUserDetails();
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
