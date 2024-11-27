import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/photo_view_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoViewScreenController>(
        global: false,
        init: PhotoViewScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: AppColors.backgroundColor,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context, hasBackButton: true),
              body: Container(
                child: controller.imageUrl != null
                    ? PhotoView(
                        imageProvider: NetworkImage(controller.imageUrl!.url),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        enableRotation: true,
                      )
                    : controller.imageBytes != null
                        ? PhotoView(
                            imageProvider:
                                MemoryImage(controller.imageBytes!.memoryData),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            enableRotation: true,
                          )
                        : Center(
                            child: Text(
                              'No image available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
              ),
            ));
  }
}
