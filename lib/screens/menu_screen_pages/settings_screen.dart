import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/settings_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/settings_screen_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenController>(
      init: SettingsScreenController(),
      builder: (controller) => CustomScaffold(
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText: 'Setting',
          hasBackButton: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsListTileWidget(
                        titleText: 'Change Password',
                        onTap: () {
                          Get.toNamed(AppPageNames.changePasswordPromptScreen);
                        },
                        settingsValueTextWidget: const Text(''),
                      ),
                      AppGaps.hGap24,
                      /* SettingsListTileWidget(
                      titleText: 'Change Language',
                      onTap: () {},
                      settingsValueTextWidget: const Text('')),
                  AppGaps.hGap24, */
                      SettingsListTileWidget(
                          titleText: 'Delete Account',
                          onTap: () {
                            Get.toNamed(AppPageNames.deleteAccountScreen);
                          },
                          settingsValueTextWidget: const Text('')),
                    ],
                  ),
                ))
              ],
            )),
      ),
    );
  }
}
