import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/menu_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/api_helper.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';
import 'package:taxiappdriver/widgets/screen_widget/drawer_address.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuScreenController>(
        global: false,
        init: MenuScreenController(),
        builder: (controller) => Scaffold(
              // backgroundColor: Color(0xffFFFCEC),
              body: SafeArea(
                child: Center(
                  child: CustomScaffoldBodyWidget(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap40,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RawButtonWidget(
                                onTap: () async {},
                                child: SizedBox(
                                  height: 95,
                                  width: 95,
                                  child: CachedNetworkImageWidget(
                                    imageURL: controller.userDetails.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          RawButtonWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(controller.userDetails.name,
                                        textAlign: TextAlign.start,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles
                                            .semiSmallXBoldTextStyle
                                            .copyWith(
                                                color: AppColors.darkColor))),
                                controller.userDetails.status == 'approved'
                                    ? const SvgPictureAssetWidget(
                                        height: 24,
                                        width: 24,
                                        AppAssetImages.approvedSvgLogo,
                                        color: AppColors.successColor,
                                      )
                                    : controller.userDetails.status == 'pending'
                                        ? const SvgPictureAssetWidget(
                                            height: 24,
                                            width: 24,
                                            AppAssetImages.pendingSvgLogo,
                                            color: Colors.amber,
                                          )
                                        : const SvgPictureAssetWidget(
                                            height: 24,
                                            width: 24,
                                            AppAssetImages.suspendSvgLogo,
                                          )
                              ],
                            ),
                            onTap: () async {},
                          ),
                          RawButtonWidget(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(controller.userDetails.email,
                                        textAlign: TextAlign.start,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.bodySmallTextStyle
                                            .copyWith(
                                                color: AppColors.darkColor))),
                              ],
                            ),
                            onTap: () async {},
                          ),
                          AppGaps.hGap12,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
                                        color: Color(0xFFD4DAE3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Profile',
                              localAssetIconName:
                                  AppAssetImages.profilesSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () async {
                                await Get.toNamed(
                                    AppPageNames.editProfileScreen);
                                controller.getLoggedInUserDetails();
                                controller.update();
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Trip History',
                              localAssetIconName:
                                  AppAssetImages.tripHistorySvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.scheduleRideListScreen);
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Subscription',
                              localAssetIconName:
                                  AppAssetImages.subscriptionSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                controller.userDetails.vehicle.category.id != ''
                                    ? Get.toNamed(
                                        AppPageNames.subscriptionScreen,
                                        arguments: controller
                                            .userDetails.vehicle.category.id)
                                    : AppDialogs.showErrorDialog(
                                        messageText:
                                            'You Have No vehicle added,Please add your vehicle first',
                                        titleText: 'No Vehicle Found');
                                ;
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Documents',
                              localAssetIconName:
                                  AppAssetImages.documentSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.documentsScreen,
                                    arguments: controller.userDetails);
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'My Vehicle',
                              localAssetIconName:
                                  AppAssetImages.addVehicleSVGLogoLine,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.myVehicleScreen,
                                    arguments: controller.userDetails);
                              }),
                          // AppGaps.hGap24,
                          /* DrawerMenuSvgWidget(
                              text: 'My Vehicle',
                              localAssetIconName:
                                  AppAssetImages.documentSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.addVehicleScreen);
                              }), */
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Withdraw Methods',
                              localAssetIconName:
                                  AppAssetImages.withdrawSVGLogoLine,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.savedWithdrawMethodsScreen);
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Settings',
                              localAssetIconName:
                                  AppAssetImages.settingsSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.settingsScreen);
                              }),

                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'Help & Support',
                              localAssetIconName: AppAssetImages.helpSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.helpSupport);
                              }),
                          AppGaps.hGap24,
                          DrawerMenuSvgWidget(
                              text: 'About Us',
                              localAssetIconName: AppAssetImages.aboutSvgLogo,
                              color: AppColors.primaryColor,
                              onTap: () {
                                Get.toNamed(AppPageNames.aboutUsScreen);
                              }),
                          //Test=======================================
                          /* AppGaps.hGap24,
                          RawButtonWidget(
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.transactionHistoryScreen);
                              },
                              child: Text(
                                'Btn1',
                                style: TextStyle(
                                  color: AppColors.alertColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          AppGaps.hGap24,
                          RawButtonWidget(
                              onTap: () {
                                Get.toNamed(AppPageNames.packageDetailsScreen);
                              },
                              child: Text(
                                'Btn2',
                                style: TextStyle(
                                  color: AppColors.alertColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          AppGaps.hGap24,
                          RawButtonWidget(
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.receiveRideBottomSheetScreen);
                              },
                              child: Text(
                                'Btn3',
                                style: TextStyle(
                                  color: AppColors.alertColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          AppGaps.hGap24,
                          RawButtonWidget(
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.startRideBottomSheetScreen);
                              },
                              child: Text(
                                'Btn4',
                                style: TextStyle(
                                  color: AppColors.alertColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )), */
                          //====================================
                          AppGaps.hGap40,
                          // AppGaps.hGap24,
                          RawButtonWidget(
                            onTap: () {
                              // Helper.logout();
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.255,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Do You Want to sign out?',
                                              style: AppTextStyles
                                                  .titleSemiSmallSemiboldTextStyle),
                                          AppGaps.hGap8,
                                          const Text(
                                              'Stay signed in to book your next trip faster',
                                              style: AppTextStyles
                                                  .bodyMediumTextStyle),
                                          AppGaps.hGap25,
                                          CustomStretchedTextButtonWidget(
                                            onTap: () {
                                              Navigator.pop(context);
                                              Helper.logout();
                                            },
                                            buttonText: 'Confirm sign-out',
                                          ),
                                          AppGaps.hGap12,
                                          CustomStretchedOutlinedTextButtonWidget(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              buttonText: 'Cancel')
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Row(
                              children: [
                                AppGaps.wGap8,
                                SvgPictureAssetWidget(
                                  AppAssetImages.logoutSVGLogoLine,
                                  height: 24,
                                  width: 24,
                                  color: AppColors.alertColor,
                                ),
                                AppGaps.wGap8,
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: AppColors.alertColor,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          AppGaps.hGap24,

                          /* DrawerMenuSvgWidget(
                              text: 'Log Out',
                              localAssetIconName:
                                  AppAssetImages.logoutSVGLogoLine,
                              color: AppColors.alertColor,
                              onTap: controller.onLogOutButtonTap), */
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
