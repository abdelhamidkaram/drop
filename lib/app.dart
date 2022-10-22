import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/theme/app_theme.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropApp extends StatelessWidget {
  const DropApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context , child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: appTheme(),
        onGenerateRoute: AppRoute.onGenerateRoute,
        builder: EasyLoading.init(),
      );
    }
    );
  }
}
