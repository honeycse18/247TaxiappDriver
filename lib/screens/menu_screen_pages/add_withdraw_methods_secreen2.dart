import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:taxiappdriver/controller/add_withdraw_method_second_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class AddWithdrawMethodSecondScreen extends StatelessWidget {
  const AddWithdrawMethodSecondScreen({super.key});
  String formatLabelText(String param) {
    return param
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWithdrawMethodSecondScreenController>(
        init: AddWithdrawMethodSecondScreenController(),
        builder: (controller) => Scaffold(
              key: controller.bottomSheetFormKey,
              backgroundColor: const Color(0xFFF7F7FB),
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleText: 'Add Withdraw Methods',
              ),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap20,
                  ),
                  SliverList.separated(
                    itemCount: controller.neededParams.length,
                    itemBuilder: (context, index) {
                      final param = controller.neededParams[index];
                      if (param.toLowerCase() == "expiry date") {
                        return GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              controller.textControllers[param]?.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            }
                          },
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: controller.textControllers[param],
                              labelText: formatLabelText(param),
                              hintText: 'Enter $param',
                            ),
                          ),
                        );
                      } else {
                        return CustomTextFormField(
                          controller: controller.textControllers[param],
                          labelText: formatLabelText(param),
                          hintText: 'Enter $param',
                        );
                      }
                    },
                    separatorBuilder: (context, index) => AppGaps.hGap16,
                  ),
                  /* SliverList.separated(
                  itemCount: controller.neededParams.length,
                  itemBuilder: (context, index) {
                    final param = controller.neededParams[index];
                    return CustomTextFormField(
                      controller: controller.textControllers[param],
                      labelText: param,
                      hintText: 'Enter $param',
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.hGap16) */
                  const SliverToBoxAdapter(
                    child: AppGaps.hGap20,
                  ),
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StretchedTextButtonWidget(
                      isLoading: controller.isLoading,
                      onTap: controller.id != ''
                          ? controller.onEditDataTap
                          : controller.onSubmitTap,
                      backgroundColor: AppColors.primaryColor,
                      buttonText: 'Submit',
                    ),
                    AppGaps.hGap15
                  ],
                ),
              ),
            ));
  }
}
