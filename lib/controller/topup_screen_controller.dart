import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/model/fakeModel/payment_option_model.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class TopUpScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  TextEditingController topUpAmount = TextEditingController();
  String? screenTitle = 'Top Up';
  int selectedPaymentMethodIndex = -1;
  String id = '';
  FakePaymentOptionModel _selectedPaymentOption = FakePaymentOptionModel();
  FakePaymentOptionModel get selectedPaymentOption => _selectedPaymentOption;
  set selectedPaymentOption(FakePaymentOptionModel value) {
    _selectedPaymentOption = value;
    update();
  }

  int amount = 1;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  final PageController imageController = PageController(keepPage: false);
  bool get shouldEnableTopupButton =>
      topUpAmount.text.isNotEmpty || selectedPaymentOption.isNotEmpty;

/*<-----------Topup wallet from API ----------->*/
  Future<void> topUpWallet() async {
    Map<String, dynamic> requestBody = {
      'method': selectedPaymentOption.key,
      'amount': double.tryParse(topUpAmount.text),
    };
    isLoading = true;
    RawAPIResponse? response = await APIRepo.topUpWallet(requestBody);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessStartRentStatus(response);
  }

  _onSuccessStartRentStatus(RawAPIResponse response) async {
    final value = await launchUrl(Uri.parse(response.data));
    if (value) {
      await Future.delayed(Duration(seconds: 10));
      Get.back();
    }
  }
/*<----------- Fetch screen navigation argument----------->*/

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      screenTitle = params;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
