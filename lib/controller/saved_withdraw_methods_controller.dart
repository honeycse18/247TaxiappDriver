import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class SavedWithdrawMethodsController extends GetxController {
  Future<void> onAddButtonTap() async {
    await Get.toNamed(AppPageNames.addWithdrawMethodsScreen);
    getSavedWithdrawMethods();
    update();
  }

  Future<void> oneEditButtonTap(String id) async {
    await Get.toNamed(AppPageNames.addWithdrawMethodSecondScreen,
        arguments: id);
    getSavedWithdrawMethods();
    update();
  }

  List<SavedWithdrawMethods> saveWithdrawMethods = [];

  Future<void> getSavedWithdrawMethods() async {
    SavedWithdrawMethodsResponse? response =
        await APIRepo.getSavedWithdrawMethods();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(SavedWithdrawMethodsResponse response) {
    saveWithdrawMethods = response.data;
    update();
  }

  @override
  void onInit() {
    getSavedWithdrawMethods();
    super.onInit();
  }
}
