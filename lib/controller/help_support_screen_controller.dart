import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/dashboard_police_response.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class HelpSupportScreenController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  PoliceData faqData = PoliceData.empty();
  RxBool toggleNotification = true.obs;
  String get currentLanguageText {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      return currentLanguageName;
    }
    return '';
  }

  Future<void> getDashBoardDetails() async {
    DashboardEmergencyDataResponse? response =
        await APIRepo.getDashBoardEmergencyDataDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    _onSuccessGetDashBoard(response);
  }

  void _onSuccessGetDashBoard(DashboardEmergencyDataResponse response) async {
    faqData = response.data;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getDashBoardDetails();
    super.onInit();
  }
}
