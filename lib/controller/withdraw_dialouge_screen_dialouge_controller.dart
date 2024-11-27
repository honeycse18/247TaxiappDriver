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

class WithdrawDialogWidgetScreenController extends GetxController {
  TextEditingController amountController = TextEditingController();
  RxBool isElementsLoading = false.obs;
  List<SavedWithdrawMethods> withdrawMethod = [];
  List<SavedWithdrawMethods> selectedWithdrawMethod = [];
  SavedWithdrawMethods? selectedSavedWithdrawMethod;
  SavedWithdrawMethods? lastSelectedMethod;
  final GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();

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
    if (withdrawKey.currentState?.validate() ?? false) {
      requestWithdraw();
    }
  }

  Future<void> requestWithdraw() async {
    isLoading = true;
    final Map<String, dynamic> requestBody = {
      'amount': double.tryParse(amountController.text) ?? 0,
      'withdraw_method': selectedSavedWithdrawMethod?.id,
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
    getWithdrawMethod();
    super.onInit();
  }
}
