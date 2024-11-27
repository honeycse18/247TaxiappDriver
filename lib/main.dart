import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/app_notification_service.dart';
import 'package:taxiappdriver/utils/helpers/app_pages.dart';
import 'package:taxiappdriver/utils/helpers/app_singleton.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/theme.dart';

void main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await AppSingleton.instance.initialize();
  await Firebase.initializeApp();
  await LocalNotificationService.initialize();

  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen(onForegroundHandler);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<void> onForegroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '247TaxiAppDriver',
      getPages: AppPages.pages,
      theme: AppThemeData.appThemeData,
      initialRoute: AppPageNames.rootScreen,
    );
  }
}
