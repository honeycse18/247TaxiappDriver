import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:taxiappdriver/controller/selectlocation_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return GetBuilder<SelectLocationScreenController>(
      global: false,
      init: SelectLocationScreenController(),
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            titleWidget: Text(controller.screenTitle)),
        body: Stack(
          children: [
            Positioned.fill(
                child: GoogleMap(
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition:
                  AppSingleton.instance.defaultCameraPosition,
              markers: controller.googleMapMarkers,
              onMapCreated: controller.onGoogleMapCreated,
              onTap: controller.onGoogleMapTap,
            )),
            if (controller.mapMarked)
              Positioned(
                  width: MediaQuery.of(context).size.width,
                  bottom: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomStretchedButtonWidget(
                      onTap: controller.onConfirmLocationButtonTap,
                      child: Text(AppLanguageTranslation
                          .confirmTransKey.toCurrentLanguage),
                    ),
                  )),
            if (controller.showCurrentLocation)
              Positioned(
                right: 30,
                bottom: controller.mapMarked ? 150 : 30,
                child: GestureDetector(
                  onTap: () => controller.getCurrentPosition(context),
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPictureAssetWidget(
                            AppAssetImages.locationSVGLogoLine),
                      )),
                ),
              ),
            ScaffoldBodyWidget(
                child: Column(children: [
              if (Platform.isIOS) AppGaps.hGap60,
              if (Platform.isAndroid) AppGaps.hGap114,
              Center(
                child: TypeAheadField(
                  errorBuilder: (context, error) => const Center(
                    child: Text(
                      'Error Happened!',
                      style: TextStyle(color: AppColors.errorColor),
                    ),
                  ),
                  textFieldConfiguration: TextFieldConfiguration(
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: controller.screenTitle,
                      prefix: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPictureAssetWidget(
                            AppAssetImages.locationSVGLogoLine),
                      ),
                    ),
                    onTap: () {
                      controller.keyBoardHidden = !controller.keyBoardHidden;
                      if (controller.keyBoardHidden) {
                        Helper.hideKeyBoard();
                      }
                    },
                    focusNode: controller.focusSearchBox,
                    controller: controller.locationTextEditingController,
                    onTapOutside: (event) => Helper.hideKeyBoard(),
                  ),
                  itemBuilder: (context, Prediction suggestion) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.bodyTextColor,
                        ),
                        AppGaps.wGap10,
                        Expanded(
                          child: Text(suggestion.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.bodyTextColor,
                                fontSize: 15,
                              )),
                        ),
                      ]),
                    );
                  },
                  itemSeparatorBuilder: (context, index) => Container(
                    height: 1,
                    color: AppColors.bodyTextColor,
                  ),
                  suggestionsCallback: (pattern) async {
                    return await controller.searchLocation(context, pattern);
                  },
                  onSuggestionSelected: (Prediction suggestion) {
                    log('My location is :  ${suggestion.description!}');
                    controller.setLocation(
                        suggestion.placeId!,
                        suggestion.description!,
                        controller.googleMapController);
                  },
                ) /* CustomTextFormField(
                      onTap: () => Get.dialog(LocationSearchDialog(
                          mapController: controller.googleMapController)),
                      controller: controller.locationTextEditingController,
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.locationSVGLogoLine),
                      hintText: 'Search Location',
                    ) */
                ,
              )
            ]))
          ],
        ),
      ),
    );
  }
}
