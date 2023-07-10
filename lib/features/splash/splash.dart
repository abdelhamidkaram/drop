import 'dart:async';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/injection_container.dart' as di ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/route/app_route.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;


  _startDelay() {
    _timer = Timer( const Duration(seconds: 5), _goNext);
  }

  _goNext() async {
   if(await AppPreferences(di.sl()).isUserLoggedIn()){
     Navigator.pushReplacementNamed(context, AppRouteStrings.home);
   }else {
     Navigator.pushReplacementNamed(context, AppRouteStrings.welcome);
   }
  }

  @override
  void initState() {

    super.initState();
    _startDelay();
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarBrightness: Brightness.light,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
        ),
        body: Container(
          child: Center(
            child: LottieBuilder.asset(JsonManger.checkStatusButton , width: 180.w,),
        ),
      ),
    ));
  }



  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: AppColors.lightPrimaryColor,
      statusBarBrightness: Brightness.light,
    ));
  }
}
