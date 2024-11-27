import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:taxiappdriver/controller/faqa_screen_controller.dart';
import 'package:taxiappdriver/model/api_response/faq_response.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class FaqaScreen extends StatelessWidget {
  const FaqaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqaScreenController>(
        init: FaqaScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
            /*<------- AppBar ------>*/

            appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText: AppLanguageTranslation.faqaTransKey.toCurrentLanguage,
              hasBackButton: true,
            ),
            /*<------- Body Content ------>*/

            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          AppLanguageTranslation.faqaTransKey.toCurrentLanguage,
                          style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                              .copyWith(color: AppColors.primaryTextColor),
                        ),
                        AppGaps.hGap16,
                        /* <----FAQA Item----> */
                        Expanded(
                            child: CustomScrollView(
                          slivers: [
                            PagedSliverList.separated(
                                pagingController:
                                    controller.faqPagingController,
                                builderDelegate:
                                    PagedChildBuilderDelegate<FaqItems>(
                                        itemBuilder: (context, item, index) {
                                  final FaqItems faqItem = item;

                                  return ExpansionTileWidget(
                                    titleWidget: Text(faqItem.question),
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(faqItem.answer))
                                    ],
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16),
                            const SliverToBoxAdapter(child: AppGaps.hGap36),
                          ],
                        ))
                      ])),
                ),
              ],
            )));
  }
}
