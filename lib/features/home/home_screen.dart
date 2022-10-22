import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropeg/config/route/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        body: Center(
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRouteStrings.onBoarding);
              },
              child: const Text("home screen ")),
        ),
      ),
    );
  }
}
