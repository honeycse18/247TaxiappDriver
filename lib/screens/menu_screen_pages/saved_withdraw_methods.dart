import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/saved_withdraw_methods_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class SavedWithdrawMethodsScreen extends StatelessWidget {
  const SavedWithdrawMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedWithdrawMethodsController>(
        init: SavedWithdrawMethodsController(),
        builder: (controller) => Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleText: 'Withdraw Methods'),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppGaps.hGap20,
                      controller.saveWithdrawMethods.isNotEmpty
                          ? Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await controller.getSavedWithdrawMethods();
                                  controller.update();
                                },
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final saveWithdrawMethods =
                                          controller.saveWithdrawMethods[index];
                                      return SavedWithdrawMethodsWidget(
                                        name: saveWithdrawMethods.type.name,
                                        logo: saveWithdrawMethods.type.logo,
                                        details: saveWithdrawMethods.details,
                                        onEditButtonTap: () =>
                                            controller.oneEditButtonTap(
                                                saveWithdrawMethods.id),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        AppGaps.hGap16,
                                    itemCount:
                                        controller.saveWithdrawMethods.length),
                              ),
                            )
                          : const Center(
                              child: EmptyScreenWidget(
                                isSVGImage: false,
                                localImageAssetURL: AppAssetImages.emptyCard,
                                title: 'No Saved Withdraw Methods Found',
                              ),
                            ),
                    ],
                  )),
              floatingActionButton: FloatingActionButton.extended(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        AppConstants.defaultBorderRadiusValue))),
                onPressed: controller.onAddButtonTap,
                label: Text('+ Add Method',
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: Colors.white)),
              ),
            ));
  }
}

class SavedWithdrawMethodsWidget extends StatelessWidget {
  final String name;
  final String details;
  final String logo;
  final void Function()? onEditButtonTap;

  const SavedWithdrawMethodsWidget({
    super.key,
    required this.name,
    required this.details,
    this.onEditButtonTap,
    required this.logo,
  });
  String formatDetails(String details) {
    final Map<String, String> detailsMap = {};
    final detailsList =
        details.replaceAll('{', '').replaceAll('}', '').split(', ');

    for (var detail in detailsList) {
      final keyValue = detail.split(': ');
      if (keyValue.length == 2) {
        detailsMap[keyValue[0]] = keyValue[1];
      }
    }

    return detailsMap.entries
        .map((entry) => '${_capitalize(entry.key)}: ${entry.value}')
        .join('\n');
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        paddingValue: const EdgeInsets.all(12),
        onTap: null,
        hasShadow: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CachedNetworkImageWidget(
                imageURL: logo,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            AppGaps.wGap10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: AppColors.primaryTextColor),
                  ),
                  AppGaps.hGap4,
                  Text(
                    formatDetails(details),
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.primaryTextColor),
                  ),
                ],
              ),
            ),
            AppGaps.wGap10,
            RawButtonWidget(
                onTap: onEditButtonTap,
                child: const Icon(
                  Icons.edit_note_sharp,
                  size: 40,
                ))
          ],
        ));
  }
}
