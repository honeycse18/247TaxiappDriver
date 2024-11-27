import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:taxiappdriver/model/locals/mixed_image_data.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:taxiappdriver/model/api_response/user_details_response.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_local_stored_keys.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/utils/helpers/image_picker_helper.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

/// This file contains helper functions and properties
class Helper {
  static Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  static String getFirstSafeString(List<String> images) {
    return images.firstOrNull ?? '';
  }

  static double getAvailableScreenHeightForBottomSheet(BuildContext context) {
    final Size screenSize = getScreenSize(context);
    final double topUnavailableSpaceValue = MediaQuery.of(context).padding.top;
    final double topAvailableSpaceValue =
        screenSize.height - topUnavailableSpaceValue;
    return topAvailableSpaceValue;
  }

  static Future<String?> get getFCMToken async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      return fcmToken;
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }

  static String getUserToken() {
    dynamic userToken =
        GetStorage().read(LocalStoredKeyName.loggedInDriverToken);
    if (userToken is! String) {
      return '';
    }
    return userToken;
  }

  static hideKeyBoard() {
    Future.delayed(
      const Duration(milliseconds: 0),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
  }

  static Future<void> setloggedInDriverToLocalStorage(
      UserDetailsData userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String userDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDriver, userDetailsJson);
  }

  static UserDetailsData getUser() {
    dynamic loggedInDriverJsonString =
        GetStorage().read(LocalStoredKeyName.loggedInDriver);
    if (loggedInDriverJsonString is! String) {
      return UserDetailsData.empty();
    }
    dynamic loggedInDriverJson = jsonDecode(loggedInDriverJsonString);
/*     if (loggedInDriverJson is! Map<String, dynamic>) {
      return UserDetails.empty();
    } */
    return UserDetailsData.getAPIResponseObjectSafeValue(loggedInDriverJson);
  }

  static void logout() async {
    GetStorage().write(LocalStoredKeyName.loggedInDriverToken, null);
    GetStorage().write(LocalStoredKeyName.loggedInDriver, null);
    await AppSingleton.instance.localBox.clear();
    Get.offAllNamed(AppPageNames.loginScreen);
  }

  static String getUserBearerToken() {
    String loggedInDriverToken = getUserToken();
    return 'Bearer $loggedInDriverToken';
  }

  static bool isUserLoggedIn() {
    return (getUserToken().isNotEmpty || (!getUser().isEmpty()));
  }

  static String getRoundedDecimalUpToTwoDigitText(double doubleNumber) {
    return doubleNumber.toStringAsFixed(2);
  }

  /// Generate Material color
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: _generateTintColor(color, 0.9),
      100: _generateTintColor(color, 0.8),
      200: _generateTintColor(color, 0.6),
      300: _generateTintColor(color, 0.4),
      400: _generateTintColor(color, 0.2),
      500: color,
      600: _generateShadeColor(color, 0.1),
      700: _generateShadeColor(color, 0.2),
      800: _generateShadeColor(color, 0.3),
      900: _generateShadeColor(color, 0.4),
    });
  }

  // Helper functions for above function
  static int _generateTintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color _generateTintColor(Color color, double factor) => Color.fromRGBO(
      _generateTintValue(color.red, factor),
      _generateTintValue(color.green, factor),
      _generateTintValue(color.blue, factor),
      1);

  static int _generateShadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color _generateShadeColor(Color color, double factor) =>
      Color.fromRGBO(
          _generateShadeValue(color.red, factor),
          _generateShadeValue(color.green, factor),
          _generateShadeValue(color.blue, factor),
          1);

  static void showSnackBar(String message) {
    BuildContext? context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static Color getColorFromTextHexColorCode(String hexCode) {
    try {
      final hexColor = hexCode.replaceFirst('#', '');
      return Color((int.tryParse(hexColor, radix: 16) ?? 0) + 0xFF000000);
    } catch (e) {
      return Colors.transparent;
    }
  }

  /// return "RRGGBB" hex color code. Example return "FFAA22"
  static String getTextHexColorCodeFromColor(Color color,
      {bool shouldInsertHashCharacter = false}) {
    final hexColorCode = color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2)
        .toUpperCase();
    if (shouldInsertHashCharacter) {
      return '#$hexColorCode';
    }
    return hexColorCode;
  }

  static String ddMMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, yyyy').format(dateTime);
  static String yyyyMMddFormattedDateTime(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);
  static String ddMMMyyyyhhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM, hh:mm a').format(dateTime);
  static String ddMMMyyyyhhmmaFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd MMM,yy | hh:mm a').format(dateTime);

  static String hhmmFormattedDateTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);
  static int dateTimeDifferenceInDays(DateTime date) {
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime.now())
        .inDays;
  }

  static String timeZoneSuffixedDateTimeFormat(DateTime dateTime) {
    // Creating a DateFormat object with the required format
    DateFormat formatter = DateFormat("yyyy-MM-ddTHH:mm:ss");

    // Formatting the DateTime object using the formatter
    String formattedDateTime = formatter.format(dateTime);

    // Calculating the timezone offset
    Duration offset = dateTime.timeZoneOffset;
    String offsetSign = offset.isNegative ? '-' : '+';
    String offsetHours = offset.inHours.abs().toString().padLeft(2, '0');
    String offsetMinutes =
        offset.inMinutes.abs().remainder(60).toString().padLeft(2, '0');

    // Constructing the final formatted date string with timezone offset
    String finalFormattedDateTime =
        '$formattedDateTime$offsetSign$offsetHours$offsetMinutes';

    return finalFormattedDateTime;
  }

  static Future<void> setLoggedInUserToLocalStorage(
      UserDetailsData userDetails) async {
    var vendorDetailsMap = userDetails.toJson();
    String userDetailsJson = jsonEncode(vendorDetailsMap);
    await GetStorage()
        .write(LocalStoredKeyName.loggedInDriver, userDetailsJson);
  }

  static Future<void> showNotification(
      {required String title, required String message, String? payload}) async {
/*     const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            Constants.notificationChannelID, Constants.notificationChannelName,
            channelDescription: Constants.notificationChannelDescription,
            importance: Importance.max,
            priority: Priority.max,
            ticker: Constants.notificationChannelTicker); */
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AppSingleton.instance.androidNotificationDetails,
        iOS: AppSingleton.instance.darwinNotificationDetails);
    await AppSingleton.instance.flutterLocalNotificationsPlugin.show(
        // getRandom6DigitGeneratedNumber(),
        generateNotificationID,
        title,
        message,
        notificationDetails,
        payload: payload);
  }

  static int get generateNotificationID {
    final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return id;
  }

  static String ddMMMFormattedDate(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);
  static String ddMMMyyyyFormattedDate(DateTime dateTime) =>
      DateFormat('dd MMM yyyy').format(dateTime);
  static String hhmmFormattedTime(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  /// Returns if today, true
  static bool isToday(DateTime date) {
    return dateTimeDifferenceInDays(date) == 0;
  }

  /// Returns if tomorrow, true
  static bool isTomorrow(DateTime date) {
    return dateTimeDifferenceInDays(date) == 1;
  }

  /// Returns if yesterday, true
  static bool wasYesterday(DateTime date) {
    return dateTimeDifferenceInDays(date) == -1;
  }

  static int getRandom6DigitGeneratedNumber() {
    Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
    double next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next.toInt();
  }

  static Future<File> getTempFileFromImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${getRandom6DigitGeneratedNumber()}.jpg')
            .create();
    return file.writeAsBytes(imageBytes);
  }

  static String getCurrencyFormattedWithDecimalAmountText(double amount,
      [int decimalDigit = 2]) {
    return AppComponents.defaultDecimalNumberFormat.format(amount);
  }

  static void scrollToStart(ScrollController scrollController) {
    if (scrollController.hasClients && !scrollController.position.outOfRange) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  static void pickImages(
      {String imageName = '',
      required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final List<image_picker.XFile>? pickedImages =
        await ImagePickerHelper.getPhoneImages();
    if (pickedImages == null || pickedImages.isEmpty) {
      return;
    }
    processPickedImages(pickedImages,
        onSuccessUploadSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static void pickImage(
      {String imageName = '',
      required void Function(Uint8List?, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      Map<String, dynamic> additionalData = const {},
      String token = ''}) async {
    final image_picker.XFile? pickedImage =
        await ImagePickerHelper.getPhoneImage();
    if (pickedImage == null) {
      return;
    }
    processPickedImage(pickedImage,
        onSuccessUploadSingleImage: onSuccessUploadSingleImage,
        imageName: imageName,
        additionalData: additionalData,
        token: token);
    AppDialogs.showProcessingDialog(message: 'Image is processing');
  }

  static String formatTitle(String title) {
    return title
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static void processPickedImages(List<image_picker.XFile> pickedImages,
      {required void Function(List<Uint8List>, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    List<Uint8List>? processedImages =
        await ImagePickerHelper.getProcessedImages(pickedImages);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    /* if (processedImages == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    } */
    // final String messageText = imageName.isEmpty
    //     ? 'Are you sure to set this image?'
    //     : 'Are you sure to set this image as $imageName?';
    /*  Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    ); */
    // if (confirmResponse is bool && confirmResponse) {
    onSuccessUploadSingleImage(processedImages, additionalData);

    // }
  }

  static void processPickedImage(image_picker.XFile pickedImage,
      {required void Function(Uint8List?, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      required String imageName,
      required Map<String, dynamic> additionalData,
      required String token}) async {
    Uint8List? processedImage =
        await ImagePickerHelper.getProcessedImage(pickedImage);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    /* if (processedImages == null) {
      AppDialogs.showErrorDialog(
          messageText: 'Error occurred while processing image');
      return;
    } */
    // final String messageText = imageName.isEmpty
    //     ? 'Are you sure to set this image?'
    //     : 'Are you sure to set this image as $imageName?';
    /*  Object? confirmResponse = await AppDialogs.showConfirmDialog(
      shouldCloseDialogOnceYesTapped: false,
      messageText: messageText,
      onYesTap: () async {
        return Get.back(result: true);
      },
    ); */
    // if (confirmResponse is bool && confirmResponse) {
    onSuccessUploadSingleImage(processedImage, additionalData);

    // }
  }

  static String getRelativeDateTimeText(DateTime dateTime) {
    return DateTime.now().difference(dateTime).inDays == 1
        ? 'Yesterday'
        : timeago.format(dateTime);
  }

  static String ddMMyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd/MM/yy').format(dateTime);

  static String ddMMyyyyFormattedDateTime(DateTime dateTime) =>
      DateFormat('dd-MM-yyyy').format(dateTime);

  static String hhMMaFormattedDate(DateTime dateTime) =>
      DateFormat('hh:mm a').format(dateTime);

  static String dayFullFormattedDateTime(DateTime dateTime) =>
      DateFormat('EEEE').format(dateTime);

  static String hhmm24FormattedDateTime(TimeOfDay dateTime) =>
      DateFormat('hh:mm').format(
          DateTime(DateTime.now().year, 1, 0, dateTime.hour, dateTime.minute));

  static String avatar2LetterUsername(String firstName, String lastName) {
    if (lastName.isEmpty) {
      if (firstName.isEmpty) {
        return '';
      }
      final firstCharacter = firstName.characters.first;
      final secondCharacter = firstName.characters.length >= 2
          ? firstName.characters.elementAt(1)
          : '';
      return '$firstCharacter$secondCharacter';
    }
    if (firstName.isEmpty) {
      return '';
    }
    final firstCharacter = firstName.characters.first;
    final secondCharacter = lastName.characters.first;
    return '$firstCharacter$secondCharacter';
  }

  static String? withdrawValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
    }
    return null;
  }

  static ({String dialCode, String strippedPhoneNumber})?
      separatePhoneAndDialCode(String fullPhoneNumber) {
    final foundCountryCode = codes.firstWhereOrNull(
        (code) => fullPhoneNumber.contains(code['dial_code'] ?? ''));
    if (foundCountryCode == null) {
      return null;
    }
    var dialCode = fullPhoneNumber.substring(
      0,
      foundCountryCode["dial_code"]!.length,
    );
    var newPhoneNumber = fullPhoneNumber.substring(
      foundCountryCode["dial_code"]!.length,
    );
    return (dialCode: dialCode, strippedPhoneNumber: newPhoneNumber);
  }

  static String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return 'Invalid phone number format';
      }
      return null;
    }
    return null;
  }

  static String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return 'Invalid email format';
      }
      return null;
    }
    return null;
  }

  static String? passwordFormValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Password is required';
    } else if (text.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'(?=.*?[A-Z])').hasMatch(text)) {
      return 'Password must include at least 1 uppercase letter';
    } else if (!RegExp(r'(?=.*?[a-z])').hasMatch(text)) {
      return 'Password must include at least 1 lowercase letter';
    } else if (!RegExp(r'(?=.*?[0-9])').hasMatch(text)) {
      return 'Password must include at least 1 number';
    } else if (!RegExp(r'(?=.*?[!@#$%^&*])').hasMatch(text)) {
      return 'Password must include at least 1 special character (!@#\$%^&*)';
    }
    return null;
  }

  /// used to check User name Input Field Should no empty
  static String? textFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (text.length < 3) return 'Minimum length 3';
    }
    return null;
  }

  static String? numberFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) return 'Can not be empty';
      if (text.length < 4) return 'Minimum length 4';
    }
    return null;
  }

  static List<String> extractImageURLsFromMixedImageData(
          List<dynamic> mixedImageData) =>
      mixedImageData.whereType<String>().toList();

  static List<String> extractImageURLsFromMixedImage(
          List<MixedImageData> mixedImageData) =>
      mixedImageData.whereType<URLImageData>().map((e) => e.url).toList();

  static List<Uint8List> extractImageMemoryDataFromMixedImageData(
          List<dynamic> mixedImageData) =>
      mixedImageData.whereType<Uint8List>().toList();

  static List<Uint8List> extractImageMemoryDataFromMixedImage(
          List<MixedImageData> mixedImageData) =>
      mixedImageData
          .whereType<MemoryImageData>()
          .map((e) => e.memoryData)
          .toList();

  static void getBackToHomePage() {
    Get.until((route) => Get.currentRoute == AppPageNames.zoomDrawerScreen);
  }
}
