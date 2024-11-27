import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/drawer_screen_controller.dart';
import 'package:taxiappdriver/screens/home_navigator_screen.dart';
import 'package:taxiappdriver/screens/zoom_drawer/menu_screen.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:upgrader/upgrader.dart';

class ZoomDrawerScreen extends StatelessWidget {
  const ZoomDrawerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomDrawerScreenController>(
      global: true,
      init: ZoomDrawerScreenController(),
      builder: (controller) => PopScope(
        onPopInvoked: (didPop) {
          controller.onClose();
        },
        child: UpgradeAlert(
          child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: ZoomDrawer(
              menuBackgroundColor: AppColors.backgroundColor.withOpacity(0.5),
              controller: controller.zoomDrawerController,
              menuScreen: const MenuScreen(),
              mainScreen: const HomeNavigatorScreen(),
              showShadow: true,
              disableDragGesture: true,
              androidCloseOnBackTap: true,
              mainScreenTapClose: true,
              moveMenuScreen: true,
              style: DrawerStyle.defaultStyle,
              angle: 0.0,
              isRtl: false,
            ),
          ),
        ),
      ),
    );
  }
}
