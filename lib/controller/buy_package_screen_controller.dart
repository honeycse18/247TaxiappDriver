import 'dart:developer';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/model/core_api_responses/raw_api_response.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/model/fakeModel/payment_option_model.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyPackageScreenController extends GetxController {
  String subscriptionId = '';
  int selectedPaymentMethodIndex = 0;

  UserDetailsData userDetails = UserDetailsData.empty();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  SubscriptionListItem subscription = SubscriptionListItem.empty();
  List<String> featuresList = [];
  FakePaymentOptionModel selectedPaymentOption =
      FakeData.subscriptionPaymentOptions[0];

  Future<void> buyPackageRequest() async {
    isLoading = true;
    final Map<String, String> requestBody = {
      'subscription': subscription.id,
      'method': selectedPaymentOption.key,
    };
    RawAPIResponse? response =
        await APIRepo.buySubscriptionPackageMethod(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSucessPaymentStatus(response);
  }

  _onSucessPaymentStatus(RawAPIResponse response) async {
    await launchUrl(Uri.parse(response.data));
    update();

    isLoading = false;
    await _initializeAfterDelay(response);
    Get.back();
    Get.back();
  }

  Future<void> _initializeAfterDelay(RawAPIResponse response) async {
    await Future.delayed(const Duration(seconds: 10));
    // AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is SubscriptionListItem) {
      subscription = params;
      featuresList = subscription.features;
      update();
    }
  }

  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
