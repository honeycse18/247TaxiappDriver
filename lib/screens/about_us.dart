import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:taxiappdriver/controller/about_us_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsScreenController>(
        global: false,
        init: AboutUsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,

              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.aboutUsTransKey.toCurrentLanguage),

              /* <-------- Content --------> */

              body: ScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      HtmlWidget(controller.supportTextItem.content),
                      AppGaps.hGap50,
                    ],
                  ),
                ),
              ), /* <-------- Bottom bar of sign up text --------> */
            ));
  }
}
