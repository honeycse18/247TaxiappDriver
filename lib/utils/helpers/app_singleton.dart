import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';

class AppSingleton {
  static AppSingleton? _instance;

  late Box localBox;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(AppConstants.notificationChannelID,
          AppConstants.notificationChannelName,
          channelDescription: AppConstants.notificationChannelDescription,
          importance: Importance.max,
          priority: Priority.max,
          ticker: AppConstants.notificationChannelTicker);

  final DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
    // sound: 'sound.mp3',
    presentAlert: true,
    presentBadge: true,
    presentBanner: true,
    presentSound: true,
    // presentList:
  );
  Future<void> initialize() async {
    await Hive.initFlutter();
    localBox = await Hive.openBox(AppConstants.hiveBoxName);
  }

  CameraPosition defaultCameraPosition = AppConstants.defaultMapCameraPosition;

  AppSingleton._();

  static AppSingleton get instance => _instance ??= AppSingleton._();
}
