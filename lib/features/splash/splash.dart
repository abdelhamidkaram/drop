import 'dart:async';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/injection_container.dart' as di ;
import '../../config/route/app_route.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  Timer? _timer2;
  double op = 0;
  _startDelay() {
    _timer = Timer( const Duration(seconds: 5), _goNext);
    _timer2 = Timer(const Duration(milliseconds: 50) , (){
      setState(() {
        op = 1 ;
      });
    });
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
      statusBarColor: AppColors.primaryColor,
      statusBarBrightness: Brightness.light,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
        ),
        body: Container(
          decoration:   BoxDecoration(
            gradient:  LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.lightPrimaryColor,
              ] ,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [
                0.3,
                0.9
              ],
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
                duration: const Duration(seconds: 5),
                opacity: op,
                child: Image.asset("assets/images/logo.png" , width: 200, height: 50,color: AppColors.white,)),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }
}
