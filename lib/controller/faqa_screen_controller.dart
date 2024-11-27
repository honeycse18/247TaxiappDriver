import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/dashboard_police_response.dart';
import 'package:taxiappdriver/model/api_response/faq_response.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqaScreenController extends GetxController {
  PoliceData faqData = PoliceData.empty();

  PagingController<int, FaqItems> faqPagingController =
      PagingController(firstPageKey: 1);

  /*<-----------Get FAQA item list from API ----------->*/

  Future<void> getFaqItemList(int currentPageNumber) async {
    FaqResponse? response = await APIRepo.getFaqItemList(currentPageNumber);
    if (response == null) {
      onErrorGetFaqItemList(response);

      return;
    } else if (response.error) {
      onFailureGetFaqItemList(response);

      return;
    }
    onSuccessGetHireDriverList(response);
  }

  void onErrorGetFaqItemList(FaqResponse? response) {
    faqPagingController.error = response;
  }

  void onFailureGetFaqItemList(FaqResponse response) {
    faqPagingController.error = response;
  }

  void onSuccessGetHireDriverList(FaqResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      faqPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    faqPagingController.appendPage(response.data.docs, nextPageNumber);
  }
  /*<-----------Get dashboard details from API ----------->*/

  Future<void> getDashBoardDetails() async {
    DashboardEmergencyDataResponse? response =
        await APIRepo.getDashBoardEmergencyDataDetails();
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseForthisOperationTranskey.toCurrentLanguage);
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

  Future<void> launchMailApp(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  void onWhatsappTap() {}
/* <---- Initial state ----> */

  @override
  void onInit() {
    getDashBoardDetails();
    faqPagingController.addPageRequestListener((pageKey) {
      getFaqItemList(pageKey);
    });
    super.onInit();
  }
}
