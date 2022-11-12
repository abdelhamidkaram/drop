import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';

ThemeData appTheme() => ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.hit,
        brightness: Brightness.light,
        bottomAppBarColor: AppColors.backGround,
        bottomSheetTheme: const  BottomSheetThemeData(
          backgroundColor: Colors.transparent
        ),
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
        cardTheme:  CardTheme(
          elevation: 10,
          color: AppColors.cardBackGround,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          headline2: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          headline3: TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          headline5:  TextStyle(
            fontFamily: AppStrings.fontFamily,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          headline6: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.grey
          ),
        ),

        

    );