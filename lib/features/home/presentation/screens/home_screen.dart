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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteStrings.profile);
                  },
                  child: const Text("home screens ")),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteStrings.onBoarding);
                  },
                  child: const Text("onBoarding ")),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteStrings.welcome);
                  },
                  child: const Text("welcome ")),
            ),
          ],
        ),
      ),
    );
  }
}
