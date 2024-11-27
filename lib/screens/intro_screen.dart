import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taxiappdriver/controller/intro_screen_controller.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:taxiappdriver/widgets/screen_widget/intro_screen_widget.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<IntroScreenController>(
      init: IntroScreenController(),
      global: false,
      builder: (controller) => Scaffold(
        body: Stack(
          children: [
            // Intro screens
            Positioned.fill(
              child: IntroImageContentWidget(
                localImageLocation:
                    controller.fakeIntroContent.localSVGImageLocation,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 363,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.curveColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(150),
                  ),
                  border: const Border(
                    top: BorderSide(
                      color: AppColors.primaryColor,
                      width: 4,
                    ),
                  ),
                ),
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.fakeIntroContent = FakeData.introContents[index];
                    controller.update();
                  },
                  itemCount: FakeData.introContents.length,
                  itemBuilder: (context, index) {
                    controller.fakeIntroContent = FakeData.introContents[index];
                    return IntroSloganContentWidget(
                      slogan: controller.fakeIntroContent.slogan,
                      subtitle: controller.fakeIntroContent.content,
                    );
                  },
                ),
              ),
            ),
            /* Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 110),
                child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: FakeData.introContents.length,
                  axisDirection: Axis.horizontal,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 2,
                    expansionFactor: 3,
                    activeDotColor: AppColors.primaryColor,
                    dotColor: AppColors.mainBgColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 25,
              right: 25,
              child: Center(
                child: CustomStretchedButtonWidget(
                  onTap: () {
                    Get.toNamed(AppPageNames.loginScreen);
                  },
                  child: Text('Get Started'),
                ),
              ),
            ), */
            Positioned(
              bottom: 10,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.gotoPreviousIntroSection(context);
                          },
                          icon: SvgPicture.asset(
                              AppAssetImages.leftArrowSVGLogoLine,
                              color: AppColors.infoColor)),
                      SmoothPageIndicator(
                        controller: controller.pageController,
                        count: FakeData.introContents.length,
                        axisDirection: Axis.horizontal,
                        effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 2,
                            expansionFactor: 3,
                            activeDotColor: AppColors.primaryColor,
                            dotColor: AppColors.infoColor),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.gotoNextIntroSection(context);
                          },
                          icon: SvgPicture.asset(
                              AppAssetImages.rightArrowSVGLogoLine,
                              color: AppColors.infoColor))
                    ],
                  ),
                  CustomStretchedButtonWidget(
                    onTap: controller.onContinueButtonTap,
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
