import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/choose_reason_cancel_ride_controller.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/widgets/cancel_reason_screen_widgets.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ChooseReasonCancelRideBottomSheet extends StatelessWidget {
  const ChooseReasonCancelRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<CancelReasonRideBottomSheetController>(
        init: CancelReasonRideBottomSheetController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                /* <-------- AppBar --------> */
                AppBar(
                  backgroundColor: AppColors.backgroundColor,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  leading: Center(
                    child: CustomIconButtonWidget(
                        onTap: () {
                          Get.back();
                        },
                        hasShadow: true,
                        child: const SvgPictureAssetWidget(
                          AppAssetImages.arrowLeftSVGLogoLine,
                          color: AppColors.primaryTextColor,
                          height: 18,
                          width: 18,
                        )),
                  ),
                  title: Text(AppLanguageTranslation
                      .chooseAReasonTransKey.toCurrentLanguage),
                ),
                /* <-------- 27px height gap --------> */
                AppGaps.hGap27,
                Expanded(
                    /* <-------- Scroolable Content --------> */
                    child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: FakeData.cancelRideReason.length,
                      itemBuilder: (context, index) {
                        final cancelReason = FakeData.cancelRideReason[index];
                        /* <-------- Cancel Reason Options List View --------> */
                        return CancelReasonOptionListTileWidget(
                          cancelReason: cancelReason,
                          selectedCancelReason: controller.selectedCancelReason,
                          reasonName: cancelReason.reasonName,
                          hasShadow: controller.selectedReasonIndex == index,
                          onTap: () {
                            controller.selectedReasonIndex = index;
                            controller.selectedCancelReason = cancelReason;
                            controller.update();
                          },
                          radioOnChange: (Value) {
                            controller.selectedReasonIndex = index;
                            controller.selectedCancelReason = cancelReason;
                            controller.update();
                          },
                          index: index,
                          selectedPaymentOptionIndex:
                              controller.selectedReasonIndex,
                        );
                      },
                      /* <--------  16px height gap between widgets --------> */
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                    /* <-------- 16px height gap --------> */
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    if (controller.selectedCancelReason.reasonName == 'Other')
                      SliverToBoxAdapter(
                        child: CustomTextFormField(
                          controller: controller.otherReasonTextController,
                          hintText: 'Write your reason here......',
                          maxLines: 3,
                        ),
                      ),
                    /* <-------- 16px height gap --------> */
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                  ],
                )),
                /* <-------- Submit Button --------> */
                CustomStretchedTextButtonWidget(
                  buttonText: AppLanguageTranslation
                      .submitReasonTransKey.toCurrentLanguage,
                  onTap: controller.onSubmitButtonTap,
                )
              ]),
            ));
  }
}
