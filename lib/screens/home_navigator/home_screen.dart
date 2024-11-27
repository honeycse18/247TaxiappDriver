import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiappdriver/controller/home_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => PopScope(
        onPopInvoked: (didPop) {
          controller.onClose();
        },
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Obx(() => GoogleMap(
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition:
                        AppSingleton.instance.defaultCameraPosition,
                    /* CameraPosition(
                          target: controller.currentLocation.value ??
                              const LatLng(22.8456, 89.5403),
                          zoom: 14.0,
                        ), */
                    markers: {
                      Marker(
                          markerId: const MarkerId('driver_location'),
                          position: controller.userLocation.value,
                          icon: controller.myCarIcon ??
                              BitmapDescriptor.defaultMarker),
                    },
                    polylines: controller.googleMapPolylines,
                    onMapCreated: controller.onGoogleMapCreated,
                    onTap: controller.onGoogleMapTap,
                  )),
              Positioned(
                right: 30,
                bottom: 100,
                child: RawButtonWidget(
                  onTap: () {
                    controller.getCurrentLocation();
                  },
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: const SvgPictureAssetWidget(
                          AppAssetImages.locationSVGLogoLine,
                          color: AppColors.darkColor),
                    ),
                  ),
                ),
              ),
              controller.userDetails.isEmpty()
                  ? AppGaps.emptyGap
                  : ((!controller.isProfileApproved()) ||
                          (!controller.isCarApproved()))
                      ? Positioned(
                          top: 139,
                          left: 24,
                          right: 24,
                          child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /* Row(
                            children: [
                              RawButtonWidget(
                                  onTap: () => controller.getLoggedInUserDetails,
                                  child: Icon(Icons.replay_outlined))
                            ],
                          ), */
                                  const Text(
                                    'Submit information to activate account!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  AppGaps.hGap16,
                                  CompleteProfileWidget(
                                    onTap: controller.isProfileComplete()
                                        ? null
                                        : () async {
                                            await Get.toNamed(AppPageNames
                                                .editDocumentsScreen);
                                            await controller
                                                .getLoggedInUserDetails();
                                            controller.update();
                                          },
                                    title: 'Complete Profile',
                                    hintText:
                                        'Input you info, driving license and id card',
                                    isCompleted: controller.isProfileComplete(),
                                  ),
                                  AppGaps.hGap16,
                                  CompleteProfileWidget(
                                    onTap: controller.isVehicleComplete()
                                        ? null
                                        : () async {
                                            await Get.toNamed(
                                                AppPageNames.addVehicleScreen,
                                                arguments: controller
                                                    .userDetails.vehicle.id);
                                            await controller
                                                .getLoggedInUserDetails();
                                            controller.update();
                                          },
                                    title: 'Add Car',
                                    hintText:
                                        'Add your car documents then we will approve your car for ride.',
                                    isCompleted: controller.isVehicleComplete(),
                                  ),
                                  /*  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPictureAssetWidget(
                                AppAssetImages.notCompleteSVGLogoLine,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Add Car',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    ),
                                    Text(
                                        'Add your car documents then we will approve your car for ride.',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                              SvgPictureAssetWidget(
                                AppAssetImages.rightSingleArrowSVGLogoLine,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ), */
                                ],
                              )))
                      : AppGaps.emptyGap,
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteProfileWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String hintText;
  final bool isCompleted;
  const CompleteProfileWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.hintText,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            isCompleted
                ? AppAssetImages.completeSVGLogoLine
                : AppAssetImages.notCompleteSVGLogoLine,
          ),
          AppGaps.wGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
                Text(hintText, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          AppGaps.wGap10,
          const SvgPictureAssetWidget(
            AppAssetImages.rightSingleArrowSVGLogoLine,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
