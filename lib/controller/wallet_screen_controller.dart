import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/model/api_response/get_wallet_details_response.dart';
import 'package:taxiappdriver/model/api_response/wallet_history_response.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class WalletScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  RxBool istransactionTabSelected = false.obs;
  Rx<TransactionHistoryStatus> selectedStatus =
      TransactionHistoryStatus.today.obs;

  WalletDetailsItem walletDetails = WalletDetailsItem.empty();
  PagingController<int, TransactionHistoryItems>
      transactionHistoryPagingController = PagingController(firstPageKey: 1);
/* <---- Get Transaction History from API ----> */
  Future<void> getTransactionHistory(
      int currentPageNumber, TransactionHistoryStatus status) async {
    WalletTransactionHistoryResponse? response;
    status.stringValue == 'withdraw_history'
        ? response = await APIRepo.getWithdrawHistory(currentPageNumber)
        : response =
            await APIRepo.getTransactionHistory(currentPageNumber, status);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(WalletTransactionHistoryResponse response) {
    // transactionHistoryPagingController.appendLastPage(response.data.docs);
    // return;
    final isLastPage = !response.data.hasNextPage;

    if (isLastPage) {
      transactionHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  void onRideTabTap(TransactionHistoryStatus value) {
    selectedStatus.value = value;
    update();
    transactionHistoryPagingController.refresh();
  }
/* <---- Get wallet details from API  ----> */

  Future<void> getWalletDetails() async {
    GetWalletDetailsResponse? response = await APIRepo.getWalletDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(GetWalletDetailsResponse response) {
    walletDetails = response.data;
    update();
  }

  /* <---- Initial state ----> */

  @override
  void onInit() {
    getWalletDetails();
    transactionHistoryPagingController.addPageRequestListener((pageKey) {
      getTransactionHistory(pageKey, selectedStatus.value);
    });
    super.onInit();
  }
}
