import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class DeleteAccountScreenController extends GetxController {
  //------------Hire Me Section--------------------
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> deleteUserAccount() async {
    isLoading = true;

    RawAPIResponse? response = await APIRepo.deleteUserAccount();
    isLoading = false;

    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessEditingAccountResponse(response);
  }

  void _onSuccessEditingAccountResponse(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Helper.logout();
  }
}
