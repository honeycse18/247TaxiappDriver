import 'package:get/get.dart';
import 'dart:typed_data';

import 'package:taxiappdriver/model/locals/mixed_image_data.dart';

class PhotoViewScreenController extends GetxController {
  URLImageData? imageUrl;
  MemoryImageData? imageBytes;

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      imageUrl = URLImageData(url: params);
    } else if (params is Uint8List) {
      imageBytes = MemoryImageData(memoryData: params);
    } else if (params is URLImageData) {
      imageUrl = params;
    } else if (params is MemoryImageData) {
      imageBytes = params;
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
