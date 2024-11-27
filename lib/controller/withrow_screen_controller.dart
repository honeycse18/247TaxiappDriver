import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/get_withdraw_saved_methods.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class WithdrawScreenController extends GetxController {
  /*<----------- Initialize variable ----------->*/

  TextEditingController amountController = TextEditingController();
  RxBool isElementsLoading = false.obs;
  List<SavedWithdrawMethods> withdrawMethod = [];
  List<SavedWithdrawMethods> selectedWithdrawMethod = [];
  SavedWithdrawMethods selectedSavedWithdrawMethod =
      SavedWithdrawMethods.empty();
  SavedWithdrawMethods lastSelectedMethod = SavedWithdrawMethods.empty();
  final GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();
  int selectedwithdrawMethodIndex = -1;

  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
/*   void onSelectMethodChange(WithdrawMethodsItem? coupon) {
    if (coupon == null) {
      return;
    }
    final WithdrawMethodsItem? foundExistingCoupon = selectedWithdrawMethod
        .firstWhereOrNull((element) => element.id == coupon.id);
    if (foundExistingCoupon != null) {
      // selectedCoupons.remove(foundExistingCoupon);
    } else {
      selectedWithdrawMethod.add(coupon);
    }
    update();
  } */

  void onMethodChanged(SavedWithdrawMethods? value) {
    selectedSavedWithdrawMethod = value!;
    update();
  }

  void onAddNewMethodButtonTap() async {
    await Get.toNamed(AppPageNames.paymentMethodScreen);
  }

  void onCouponDeleteChange(int index, WithdrawMethodsItem? selectedItem) {
    selectedWithdrawMethod.remove(selectedItem);

    update();
  }

  Future<void> getWithdrawMethod() async {
    final SavedWithdrawMethodsResponse? response =
        await APIRepo.getWithdrawMethod();

    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetCoupons(response);
  }

  void _onSuccessGetCoupons(SavedWithdrawMethodsResponse response) {
    withdrawMethod = response.data;

    update();
  }

  void onContinueButtonTap() {
    requestWithdraw();
  }

  Future<void> requestWithdraw() async {
    isLoading = true;
    final Map<String, dynamic> requestBody = {
      'amount': double.tryParse(amountTextEditingController.text) ?? 0,
      'withdraw_method': selectedSavedWithdrawMethod.id == ''
          ? withdrawMethod.first.id
          : selectedSavedWithdrawMethod.id,
    };
    RawAPIResponse? response = await APIRepo.withdrawRequest(requestBody);
    isLoading = false;
    if (response == null) {
      // APIHelper.onError(AppLanguageTranslation
      //     .noResponseCallingPendingTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessCancellingRequest(response);
  }

  onSuccessCancellingRequest(RawAPIResponse response) {
    Get.back();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    getWithdrawMethod();

    super.onInit();
  }

  double balanceAmount = 0.0;
  TextEditingController amountTextEditingController = TextEditingController();

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is double) {
      balanceAmount = params;
      update();
    }
    update();
  }
}
