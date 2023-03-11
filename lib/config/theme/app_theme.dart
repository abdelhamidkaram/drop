import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';

ThemeData appTheme() => ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  popupMenuTheme: const  PopupMenuThemeData(
    shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(22.0),
          ),
        )
  ),
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.hit,
      brightness: Brightness.light,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.transparent),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.lightPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightPrimaryColor,
        centerTitle: true,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.lightPrimaryColor,
        ),
      ),
      fontFamily: AppStrings.fontFamily,
      scaffoldBackgroundColor: AppColors.backGround,
      cardTheme: CardTheme(
        elevation: 10,
        color: AppColors.cardBackGround,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            overflow: TextOverflow.ellipsis),
        displayMedium: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            overflow: TextOverflow.ellipsis),
        displaySmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
            overflow: TextOverflow.ellipsis),
        headlineSmall: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis),
        titleLarge: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.grey,
            overflow: TextOverflow.ellipsis),
      ), bottomAppBarTheme: BottomAppBarTheme(color: AppColors.backGround),
    );
