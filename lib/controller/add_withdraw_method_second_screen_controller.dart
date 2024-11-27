import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/saved_withdraw_method_details.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class AddWithdrawMethodSecondScreenController extends GetxController {
  List<String> neededParams = [];
  String methodType = '';
  String id = '';
  Map<String, TextEditingController> textControllers = {};
  UserDetailsData userDetailsData = UserDetailsData.empty();
  SavedWithdrawMethods savedWithdrawMethods = SavedWithdrawMethods.empty();

  final GlobalKey<ScaffoldState> bottomSheetFormKey =
      GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> onSubmitTap() async {
    isLoading = true;
    Map<String, dynamic> details = {};
    for (var param in neededParams) {
      details[param] = textControllers[param]?.text ?? '';
    }

    Map<String, dynamic> requestBody = {
      'user': userDetailsData.id,
      'type': methodType,
      'details': details, // Ensure details is a Map<String, dynamic>
    };
    RawAPIResponse? response = await APIRepo.addWithdrawMethod(requestBody);
    isLoading = false;

    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);

      return;
    }
    log(response.toJson().toString());
    onSuccess(response);
  }

  void onSuccess(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
      messageText: response.msg,
    );

    Get.back(result: true);
    Get.back(result: true);
  }

  Future<void> onEditDataTap() async {
    isLoading = true;
    Map<String, dynamic> details = {};
    for (var param in neededParams) {
      details[param] = textControllers[param]?.text ?? '';
    }

    Map<String, dynamic> requestBody = {
      '_id': id,
      'user': userDetailsData.id,
      'type': savedWithdrawMethods.type.id,
      'details': details, // Ensure details is a Map<String, dynamic>
    };

    RawAPIResponse? response = await APIRepo.editWithdrawMethod(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);

      return;
    }
    log(response.toJson().toString());
    onEditSuccess(response);
  }

  void onEditSuccess(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
      messageText: response.msg,
    );

    Get.back(result: true);
  }

  Future<void> getSavedWithdrawMethodsDetails(String methodId) async {
    isLoading = true;
    SavedWithdrawMethodDetailsResponse? response =
        await APIRepo.getSavedWithdrawMethodsDetails(methodId);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingCategoriesList(response);
  }

  /* onSuccessRetrievingCategoriesList(
      SavedWithdrawMethodDetailsResponse response) {
    savedWithdrawMethods = response.data;
    neededParams = savedWithdrawMethods.type.requiredFields;
    // Populate textControllers with the values from details
    /*  if (savedWithdrawMethods.details is Map<String, dynamic>) {
      (savedWithdrawMethods.details as Map<String, dynamic>)
          .forEach((key, value) {
        if (textControllers.containsKey(key)) {
          textControllers[key]?.text = value;
        } else {
          textControllers[key] = TextEditingController(text: value);
        }
      });
    } */
    update();
  } */
  onSuccessRetrievingCategoriesList(
      SavedWithdrawMethodDetailsResponse response) {
    savedWithdrawMethods = response.data;
    neededParams = savedWithdrawMethods.type.requiredFields;
    // Initialize textControllers if not already initialized
    for (var param in neededParams) {
      if (!textControllers.containsKey(param)) {
        textControllers[param] = TextEditingController();
      }
    }
    // Populate textControllers with the values from details
    if (savedWithdrawMethods.details is Map<String, dynamic>) {
      (savedWithdrawMethods.details as Map<String, dynamic>)
          .forEach((key, value) {
        textControllers[key]?.text = value;
      });
    }
    update();
  }

  void getScreenParameters() {
    dynamic param = Get.arguments;
    if (param is AddWalletScreenParameter) {
      neededParams = param.neededParams;
      methodType = param.type;
      for (var p in neededParams) {
        textControllers[p] = TextEditingController();
      }
    } else if (param is String) {
      id = param;
      getSavedWithdrawMethodsDetails(id);
    }
    update();
  }

  @override
  void onInit() {
    userDetailsData = Helper.getUser();
    getScreenParameters();
    super.onInit();
  }

  @override
  void onClose() {
    textControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.onClose();
  }
}
