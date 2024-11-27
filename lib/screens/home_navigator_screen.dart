import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/home_navigator_screen_controller.dart';
import 'package:taxiappdriver/screens/home_navigator/wallet_screen.dart';
import 'package:taxiappdriver/screens/home_navigator/home_screen.dart';
import 'package:taxiappdriver/screens/unknown_screen.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class HomeNavigatorScreen extends StatelessWidget {
  final String? titleWidget;
  const HomeNavigatorScreen({super.key, this.titleWidget = ''});

  @override
  Widget build(BuildContext context) {
    // Get width size of this screen
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeNavigatorScreenController>(
        global: false,
        init: HomeNavigatorScreenController(),
        // ignore: deprecated_member_use
        builder: (controller) => PopScope(
              onPopInvoked: (didPop) async {
                controller.onClose();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                extendBody: true,
                extendBodyBehindAppBar: true,
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: false,
                    titleText: controller.titleText,
                    titleTextStyle: controller.currentTabIndex == 2
                        ? AppTextStyles.bodyLargeBoldTextStyle
                            .copyWith(color: AppColors.infoColor)
                        : AppTextStyles.bodyLargeBoldTextStyle
                            .copyWith(color: AppColors.titleTextColor),
                    leading: RawButtonWidget(
                      onTap: () {
                        if (ZoomDrawer.of(context)?.isOpen() ?? false) {
                          ZoomDrawer.of(context)?.close();
                        } else {
                          ZoomDrawer.of(context)?.open();
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        width: 44,
                        height: 42,
                        decoration: ShapeDecoration(
                          color: AppColors.fieldbodyColor.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Center(
                          child: SvgPictureAssetWidget(
                              height: 24,
                              width: 24,
                              AppAssetImages.menuSVGLogoLine,
                              color: AppColors.darkColor),
                        ),
                      ),
                    ),
                    actions: [
                      RawButtonWidget(
                        onTap: () {
                          Get.toNamed(AppPageNames.notificationScreen);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          decoration: ShapeDecoration(
                            color: AppColors.fieldbodyColor.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Center(
                            child: SvgPictureAssetWidget(
                                height: 24,
                                width: 24,
                                AppAssetImages.notificationSVGLogoLine,
                                color: AppColors.darkColor),
                          ),
                        ),
                      ),
                    ]),
                /* <-------- Bottom bar --------> */
                body: IndexedStack(
                    index: controller.currentPageIndex,
                    children: const [
                      HomeScreen(),
                      UnknownPage(),
                      WalletScreen(),
                    ]),
                /* floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Color(0xFF45A245),
                  child: Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    controller.selectHomeNavigatorTabIndex(1);
                  },
                ), */
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  elevation: 0,
                  backgroundColor:
                      controller.isOnline ? Colors.green : Colors.red,
                  onPressed: controller.goOnlineOffline,
                  child: Center(
                    child: controller.isOnlineOfflineLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(controller.isOnline ? 'Online' : 'Offline',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: const AutomaticNotchedShape(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    )),
                  ),
                  notchMargin: 10,
                  shadowColor: AppColors.iconColor,
                  color: Colors.white,
                  child: SizedBox(
                    height: 74,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            controller.bottomMenuButton(
                                'Home', AppAssetImages.homeSVGLogoLine, 0),
                          ],
                        )),
                        AppGaps.wGap10,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Color(0xFF384354),
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                height: 5,
                              ),
                            )
                          ],
                        ),
                        AppGaps.wGap10,
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            controller.bottomMenuButton(
                                'Wallet', AppAssetImages.walletSVGLogoLine, 2),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
