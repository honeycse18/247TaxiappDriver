import 'dart:developer';
import 'dart:io';
//one_ride_user
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/exceptions/internet_connection.dart';
import 'package:taxiappdriver/model/exceptions/response_status_code.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/dialog.dart';

class APIHelper {
  static Future<void> preAPICallCheck() async {
    // Check internet connection
    final bool isConnectedToInternet = await isConnectedInternet();
    if (!isConnectedToInternet) {
      throw InternetConnectionException(message: 'Not connected to internet');
    }
  }

  static bool isResponseStatusCodeIn400(int? statusCode) {
    try {
      return (statusCode! >= 400 && statusCode < 500);
    } catch (e) {
      return false;
    }
  }

  static void postAPICallCheck(Response<dynamic> response) {
    /// Handling wrong response handling
    if (response.statusCode == null) {
      // return null;
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    if (response.statusCode != 200 &&
        !isResponseStatusCodeIn400(response.statusCode)) {
      // return null;
      throw (
        statusCode: response.statusCode,
        message: 'Response code is not valid'
      );
    }
    // Try setting response as Map
    final dynamic responseBody = response.body;
    if (responseBody == null) {
      throw Exception('responseBody is null');
    }
    if (responseBody is! Map<String, dynamic>) {
      throw const FormatException('Response type is not Map<String, dynamic>');
    }
  }

  static Map<String, String> getAuthHeaderMap() {
    String loggedInUserBearerToken = Helper.getUserBearerToken();
    return {'Authorization': loggedInUserBearerToken};
  }

  static void handleExceptions(Object? exception) {
    /// API error exception of "connection timed out" handling
    if (exception is InternetConnectionException) {
      log(exception.message);
    } else if (exception is SocketException) {
      log(exception.message);
    } else if (exception is FormatException) {
      log(exception.message);
    } else {
      log(exception.toString());
    }
  }

  static String getSafeStringValue(Object? unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeListValue<T>(Object? unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static DateTime getSafeDateTimeValue(
    Object? unsafeResponseDateTimeStringValue, {
    DateFormat? dateTimeFormat,
    bool isUTCTime = true,
  }) {
    final DateTime defaultDateTime = AppComponents.defaultUnsetDateTime;
    final String safeDateTimeStringValue =
        getSafeStringValue(unsafeResponseDateTimeStringValue);
    return getDateTimeFromServerDateTimeString(safeDateTimeStringValue,
            dateTimeFormat: dateTimeFormat, isUTCTime: isUTCTime) ??
        defaultDateTime;
  }

  static int getSafeIntValue(Object? unsafeResponseIntValue,
      [int defaultIntValue = -1]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      // Now it is safe
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDoubleValue(Object? unsafeResponseDoubleValue,
      [double defaultDoubleValue = -1]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      // Now it is safe
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBoolValue(Object? unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (GetUtils.isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      // Now it is safe
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static DateTime? getDateTimeFromServerDateTimeString(
    String dateTimeString, {
    DateFormat? dateTimeFormat,
    bool isUTCTime = true,
  }) {
    try {
      return (dateTimeFormat ?? AppComponents.apiDateTimeFormat)
          .parse(dateTimeString, isUTCTime)
          .toLocal();
    } catch (e) {
      return null;
    }
  }

  static String toServerDateTimeFormattedStringFromDateTime(DateTime dateTime) {
    return AppComponents.apiDateTimeFormat.format(dateTime.toUtc());
  }

/* 
  static APIResponseObject getSafeResponseObject(Object? unsafeResponseValue) {
    final APIResponseObject defaultValue = APIResponseObject();
    if (unsafeResponseValue == null) {
      return defaultValue;
    } else if (unsafeResponseValue is Map<String, dynamic>) {
      // Now it is safe
      return APIResponseObject.fromJson(unsafeResponseValue);
    }
    return defaultValue;
  }
 */
  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }

  static Future<bool> isConnectedInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
  }

  static void onError(String? message) {
    if (message == null) {
      return;
    }
    onNewFailure(message, '');
  }

/*   static void onFailure(String message, [String? title]) {
    AppDialogs.showErrorDialog(
        messageText: message.isEmpty ? 'Something Went Wrong' : message,
        titleText: title);
  } */

  static bool _isLogoutInitiated = false;
  static void onFailure(String message, [String? title]) {
    if (message != 'Unauthorized' && message != 'User not found') {
      AppDialogs.showErrorDialog(
          messageText: message.isEmpty
              ? 'No Data Found, Please try again later.'
              : message,
          titleText: title);
    } else {
      if (!_isLogoutInitiated) {
        _isLogoutInitiated = true;
        Get.snackbar('Please Login Again', 'Session Expired',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.errorColor.withOpacity(0.1));
        Helper.logout();
      }
    }
  }

  static void onNewFailure(String message, String title) {
    if (message != 'Unauthorized') {
      Get.snackbar(title, message);
    } else {
     if (!_isLogoutInitiated) {
        _isLogoutInitiated = true;
        Get.snackbar('Please Login Again', 'Session Expired',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.errorColor.withOpacity(0.1));
        Helper.logout();
      }
    }
  }

/*   static void uploadSingleImage(Uint8List imageByte,
      void Function(SingleImageUploadResponse) onSuccessUploadSingleImage,
      {String imageFileName = '',
      String id = '',
      required String token}) async {
    AppDialogs.showProcessingDialog(message: 'Image is uploading');
    final File imageFile = await Helper.getTempFileFromImageBytes(imageByte);
    SingleImageUploadResponse? response = await APIRepo.uploadImage(imageFile,
        imageFileName: imageFileName, id: id, token: token);
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    await deleteImageFile(imageFile);
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson()).toString());
    onSuccessUploadSingleImage(response);
  } */
/*
  static Future<void> deleteImageFile(File imageFile) async {
    try {
      await imageFile.delete();
    } catch (e) {}
  }

   static Future<void> getSiteSettings() async {
    SiteSettingsResponse? response = await APIRepo.getSiteSettings();
    if (response == null) {
      _onErrorGetSiteSettings(response);
      return;
    } else if (response.error) {
      _onFailureGetSiteSettings(response);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetSiteSettings(response);
  }

  static void _onErrorGetSiteSettings(SiteSettingsResponse? response) {
    APIHelper.onError(response?.msg);
  }

  static void _onFailureGetSiteSettings(SiteSettingsResponse response) {
    APIHelper.onFailure(response.msg);
  }

  static void _onSuccessGetSiteSettings(SiteSettingsResponse response) {
    AppSingleton.instance.settings = response.data;
  } */
}
