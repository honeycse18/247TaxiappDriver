import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_history_response.dart';
import 'package:taxiappdriver/model/api_response/subscription_list_response.dart';
import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class SubscriptionScreenController extends GetxController {
  SubscriptionListItem subscription = SubscriptionListItem.empty();
  List<SubscriptionListItem> subscriptionList = [];
  List<SubscriptionHistory> subscriptionHistoryList = [];

  UserDetailsData userDetails = UserDetailsData.empty();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  String category = '';

  Future<void> getSubscriptionList(String id) async {
    SubscriptionListResponse? response = await APIRepo.getSubscriptionList(id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingSubscriptionList(response);
  }

  onSuccessRetrievingSubscriptionList(SubscriptionListResponse response) {
    subscriptionList = response.data;
    update();
  }

  Future<void> getSubscriptionHistoryList() async {
    SubscriptionHistoryResponse? response =
        await APIRepo.getSubscriptionHistory();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessRetrievingSubscriptionHistory(response);
  }

  onSuccessRetrievingSubscriptionHistory(SubscriptionHistoryResponse response) {
    subscriptionHistoryList = response.data;
    update();
  }

  void _getScreenParameters() {
    dynamic params = Get.arguments;

    if (params is String) {
      category = params;
      getSubscriptionList(category);
      update();
    }
    update();
  }

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

  @override
  void onInit() {
    _getScreenParameters();
    getLoggedInUserDetails();
    getSubscriptionHistoryList();

    super.onInit();
  }
}
