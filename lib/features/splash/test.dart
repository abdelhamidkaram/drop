import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 70.0),
            child: Container(
              height: 70,
              width: double.infinity,
              color: AppColors.backGround,
              child: SvgPicture.asset(
                "assets/logos/logo.svg",
                color: AppColors.primaryColor,
              ),
              // child: ClipPath(
              //   clipper: WaveClip(),
              //   child: Container(color: AppColors.lightPrimaryColor,height: 70,),
              // ),
            )),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  color: Colors.red,
                  width: context.width / 2,
                  height: 50,
                ),
                Container(
                  color: Colors.green,
                  width: context.width / 2,
                  height: 50,
                ),
              ],
            ),
            const Text("splash screens "),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouteStrings.login);
              },
              child: const Text("Go To auth "),
            ),
          ],
        ),
      ),
    );
  }
}


