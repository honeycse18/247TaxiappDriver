import 'package:flutter/material.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class AddVehicleTabWidget extends StatelessWidget {
  final int tabIndex;
  final String tabName;
  final bool isLine;
  final AddVehicleTabState currentTabState;
  final AddVehicleTabState myTabState;
  const AddVehicleTabWidget({
    super.key,
    required this.tabIndex,
    required this.tabName,
    this.isLine = false,
    this.currentTabState = AddVehicleTabState.VehicleInfo,
    required this.myTabState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (tabIndex == 1)
              HorizontalLine(
                color: _getTabStateColor(myTabState, currentTabState),
                text: 'Vehicle Info',
                textcolor: _getTabStateColor(myTabState, currentTabState),
              ),
            if (tabIndex == 2)
              HorizontalLine(
                color: _getTabStateColor(myTabState, currentTabState),
                text: 'Vehicle Documents',
                textcolor: _getTabStateColor(myTabState, currentTabState),
              ),
          ],
        ));
  }

  Color _getTabStateColor(
      AddVehicleTabState myTabState, AddVehicleTabState currentTabState) {
    const Color inactiveStateColor = AppColors.curveColor;
    Color currentTabStateColor = inactiveStateColor;
    switch (myTabState) {
      case AddVehicleTabState.VehicleInfo:
        if (currentTabState == AddVehicleTabState.VehicleInfo) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddVehicleTabState.VehicleDocuments) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddVehicleTabState.VehicleDocuments:
        if (currentTabState == AddVehicleTabState.VehicleInfo) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddVehicleTabState.VehicleDocuments) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;

      default:
        currentTabStateColor = AppColors.curveColor;
    }
    return currentTabStateColor;
  }
}
