import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/profile_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileScreenController>(
        init: ProfileScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  appBarBackgroundColor: AppColors.backgroundColor,
                  screenContext: context,
                  titleText: 'Profile',
                  hasBackButton: true),
              body: ScaffoldBodyWidget(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned(
                                    child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: Image.asset(
                                                  AppAssetImages.profile)
                                              .image,
                                          fit: BoxFit.cover)),
                                )),
                                Positioned(
                                    bottom: -10,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 26,
                                        width: 26,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors
                                                  .cameraIconBorderColor,
                                              width: 3),
                                          shape: BoxShape.circle,
                                          color: AppColors.shade2,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              AppAssetImages.camera),
                                        ),
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AppGaps.hGap24,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: AppColors.shade1,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: controller.updateProfileTabWidget(
                                      isSelected: controller
                                          .isUpdateProfileOptionSelected,
                                      title: 'Personal Info',
                                      onTap: () {
                                        if (!controller
                                            .isUpdateProfileOptionSelected) {
                                          controller
                                                  .isUpdateProfileOptionSelected =
                                              !controller
                                                  .isUpdateProfileOptionSelected;
                                          controller.update();
                                        }
                                      })),
                              Expanded(
                                  child: controller.updateProfileTabWidget(
                                      isSelected: !controller
                                          .isUpdateProfileOptionSelected,
                                      title: 'Documents',
                                      onTap: () {
                                        if (controller
                                            .isUpdateProfileOptionSelected) {
                                          controller
                                                  .isUpdateProfileOptionSelected =
                                              !controller
                                                  .isUpdateProfileOptionSelected;
                                          controller.update();
                                        }
                                      }))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AppGaps.hGap24,
                    ),
                    SliverToBoxAdapter(
                        child: !controller.isUpdateProfileOptionSelected
                            ? controller.documentsTextFormField()
                            : controller.personalInfoTextFormField()),
                    SliverToBoxAdapter(
                      child: AppGaps.hGap32,
                    ),
                    /* SliverToBoxAdapter(
                        child: CustomStretchedButtonWidget(
                          
                      onTap: controller.onRegisterButtonTap,
                      child: Text('Update Profile'),
                    )), */
                  ],
                ),
              ),
            ));
  }
}
