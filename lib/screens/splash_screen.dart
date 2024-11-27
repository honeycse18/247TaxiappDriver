import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/splash_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) => Scaffold(
              body: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.asset(AppAssetImages.splashBackground).image,
                  fit: BoxFit.cover,
                )),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssetImages.logo, height: 124, width: 187),
                      AppGaps.hGap10,
                      Text(
                        '247RideDriver',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
