import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/model/api_response/withdraw_method_list_response.dart';
import 'package:taxiappdriver/model/screenParameters/accepted_request_screen_parameter.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class AddWithdrawMethodsScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  int selectedPaymentMethodIndex = 0;
  final PagingController<int, WithdrawMethodList>
      withdrawMethodsPagingController = PagingController(firstPageKey: 1);

  WithdrawMethodList selectedWithdrawMethod = WithdrawMethodList.empty();

  Future<void> onAddButtonTap(AddWalletScreenParameter neededParams) async {
    await Get.toNamed(AppPageNames.addWithdrawMethodSecondScreen,
        arguments: neededParams);
  }

  Future<void> getAddWithdrawMethods(int currentPageNumber) async {
    WithdrawMethodListResponse? response =
        await APIRepo.getAddWithdrawMethods(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // log(response.toJson().toString());
    onSuccessRetrievingResponse(response);
  }

  onSuccessRetrievingResponse(WithdrawMethodListResponse response) {
    final isLastPage = !response.data.hasNextPage;

    if (isLastPage) {
      withdrawMethodsPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    withdrawMethodsPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    withdrawMethodsPagingController.addPageRequestListener((pageKey) {
      getAddWithdrawMethods(pageKey);
    });

    super.onInit();
  }
}
