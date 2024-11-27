import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';

/// This file contain theme data of the app and initial custom default widget
/// configurations
class AppThemeData {
  static final ThemeData appThemeData = ThemeData(
      useMaterial3: false,
      // Set default font name
      fontFamily: 'Urbanist',
      primarySwatch: AppColors.primaryMaterialColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      // Setting all default textTheme based on design
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 36,
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: 26,
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontSize: 24,
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontSize: 20,
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            fontSize: 18,
            color: AppColors.darkColor,
            fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.darkColor,
            fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            fontSize: 14,
            color: AppColors.darkColor,
            fontWeight: FontWeight.w400),
      ),
      // Set default TextField theme design
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: AppColors.shade1,
          filled: true,
          hintStyle: TextStyle(color: AppColors.hintTextColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.inputFieldBorder, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide:
                  BorderSide(color: AppColors.inputFieldBorder, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide: BorderSide(color: AppColors.darkColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(AppComponents.defaultBorderRadius),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1))),
      // Set default appbar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontFamily: 'Urbanist',
            color: AppColors.darkColor,
            fontWeight: FontWeight.bold),
      ),
      popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          textStyle: TextStyle(
              color: AppColors.darkColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)));
}
