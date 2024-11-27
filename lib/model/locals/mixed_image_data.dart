import 'dart:typed_data';

import 'package:flutter/foundation.dart';

sealed class MixedImageData<T> {
  bool get isEmpty;
  bool get isNotEmpty;
}

class URLImageData extends MixedImageData<String> {
  URLImageData({required this.url});
  URLImageData.empty() : url = '';
  final String url;

  @override
  bool get isEmpty => url.isEmpty;

  @override
  bool get isNotEmpty => url.isNotEmpty;

  static String get emptyData => '';
}

class MemoryImageData extends MixedImageData<Uint8List> {
  MemoryImageData({required this.memoryData});
  MemoryImageData.empty() : memoryData = Uint8List(0);

  final Uint8List memoryData;

  @override
  bool get isEmpty => memoryData.isEmpty;

  @override
  bool get isNotEmpty => memoryData.isNotEmpty;

  static Uint8List get emptyData => Uint8List(0);
}
