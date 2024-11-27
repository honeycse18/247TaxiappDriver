import 'dart:developer';

import 'package:get/get.dart';
import 'package:taxiappdriver/model/api_response/support_text_response.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/api_repo.dart';

class PrivacyPolicyScreenController extends GetxController {
  // WebViewController webViewController = WebViewController();

  // WebViewController webViewController = WebViewController();
  SupportTextItem supportTextItem = SupportTextItem.empty();

  Future<void> getSupportText() async {
    SupportTextResponse? response =
        await APIRepo.getSupportText(slug: 'privacy_policy');
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTranskey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingCategoriesList(response);
  }

  onSuccessRetrievingCategoriesList(SupportTextResponse response) {
    supportTextItem = response.data;
    update();
  }

  @override
  void onInit() {
    getSupportText();

    super.onInit();
  }
}
