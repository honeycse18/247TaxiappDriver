import 'dart:typed_data';

import 'package:taxiappdriver/model/locals/mixed_image_data.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';

class ExtractedMixedImageData {
  List<String> imageURLs = [];
  List<Uint8List> imageMemoryDataList = [];
  ExtractedMixedImageData({
    required this.imageURLs,
    required this.imageMemoryDataList,
  });

  ExtractedMixedImageData.from(List<dynamic> mixedImageData)
      : imageMemoryDataList =
            Helper.extractImageMemoryDataFromMixedImageData(mixedImageData),
        imageURLs = Helper.extractImageURLsFromMixedImageData(mixedImageData);

  ExtractedMixedImageData.fromTyped(List<MixedImageData> mixedImageData)
      : imageMemoryDataList =
            Helper.extractImageMemoryDataFromMixedImageData(mixedImageData),
        imageURLs = Helper.extractImageURLsFromMixedImageData(mixedImageData);
}
