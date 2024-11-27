import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:taxiappdriver/controller/delete_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<DeleteAccountScreenController>(
      init: DeleteAccountScreenController(),
      global: false,
      builder: (controller) => Scaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.deleteAccountTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
        body: ScaffoldBodyWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* <-------- 30px height gap --------> */
            AppGaps.hGap30,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLanguageTranslation
                          .deleteAccountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),

                    AppGaps.hGap20,
                    Text(AppLanguageTranslation.areYouWantDeleteAccountTransKey
                        .toCurrentLanguage), //Expanded(child: Text("Description")),
                    /* <-------- 20px height gap --------> */
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation.accountTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallBoldTextStyle
                          .copyWith(color: Colors.black),
                    ),
                    /* <-------- 20px height gap --------> */
                    AppGaps.hGap20,
                    Text(
                      AppLanguageTranslation
                          .deleteAccountRemoveDataTransKey.toCurrentLanguage,
                    ),
                    /* <-------- 30px height gap --------> */
                    AppGaps.hGap30,
                    CustomStretchedButtonWidget(
                        isLoading: controller.isLoading,
                        // onTap: () {},
                        onTap: () {
                          AppDialogs.showConfirmDialog(
                              messageText:
                                  'Are you sure you want to delete your account?',
                              onYesTap: controller.deleteUserAccount);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20,
                            ),
                            Text(
                              AppLanguageTranslation
                                  .deleteTransKey.toCurrentLanguage,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
