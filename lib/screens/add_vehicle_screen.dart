import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/add_vehicle_screen_controller.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/add_vehicle_tab_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVehicleScreenController>(
      global: false,
      init: AddVehicleScreenController(),
      builder: (controller) => PopScope(
        canPop: controller.shouldPop,
        onPopInvoked: controller.onWillPopScope,
        child: Scaffold(
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                // onLeadingPressed: controller.shouldPop ? null : () => controller.onWillPopScope(true),
                onLeadingPressed: () =>
                    controller.onWillPopScope(controller.shouldPop),
                titleText:
                    controller.isEditing ? 'Edit vehicle' : 'Add Vehicle'),
            body: ScaffoldBodyWidget(
                child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap16,
                          Row(
                            children: [
                              Text(
                                'Step',
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              Text(
                                (controller.addVehicleState ==
                                        AddVehicleTabState.VehicleInfo)
                                    ? ' 1 '
                                    : ' 2 ',
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                'of 2',
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                            ],
                          ),
                          AppGaps.hGap4,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RawButtonWidget(
                                  child: AddVehicleTabWidget(
                                    isLine: true,
                                    tabIndex: 1,
                                    tabName: 'Vehicle Info',
                                    myTabState: AddVehicleTabState.VehicleInfo,
                                    currentTabState: controller.addVehicleState,
                                  ),
                                  onTap: () {
                                    controller.addVehicleState =
                                        AddVehicleTabState.VehicleInfo;
                                    controller.update();
                                  },
                                ),
                                RawButtonWidget(
                                    onTap: controller.shouldDisableNextButton
                                        ? null
                                        : () async {
                                            // await submitOrderCreate();
                                            controller.addVehicleState =
                                                AddVehicleTabState
                                                    .VehicleDocuments;
                                            controller.update();
                                          },
                                    child: AddVehicleTabWidget(
                                      isLine: true,
                                      tabIndex: 2,
                                      tabName: 'Vehicle Documents',
                                      myTabState:
                                          AddVehicleTabState.VehicleDocuments,
                                      currentTabState:
                                          controller.addVehicleState,
                                    )),
                              ]),
                          AppGaps.hGap16,
                          ...controller.currentOrderDetailsTabContentWidgets(
                              controller.addVehicleState),
                        ],
                      )),
                    ],
                  ),
                )
              ],
            )),
            bottomNavigationBar: CustomScaffoldBodyWidget(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Container(
                      child: controller.currentAddVehicleTabBottomButtonWidget(
                          controller.addVehicleState),
                    ),
                  ),
                  AppGaps.hGap10
                ],
              ),
            )),
      ),
    );
  }
}
