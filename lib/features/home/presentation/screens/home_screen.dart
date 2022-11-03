import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/drawer.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        key: homeScaffoldStateKey,
        drawer: drawer(context: context, drawerSelected: DrawerSelected.home),
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 233),
            child: CustomAppbars.homeAppBar(
                context: context,
                helloTitle:
                    "${AppStrings.hello} ${ProfileCubit.get(context).userDetails?.name ?? ''},",
                hellosubTitle: AppStrings.welcomeBack,
                onTap: () {
                  homeScaffoldStateKey.currentState?.openDrawer();
                })),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 65.h,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconsManger.locationHome,
                          width: 32.w,
                          height: 32.h,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Home",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              const Text("(Al Maadi), Al-Aqram St."),
                            ],
                          ),
                        ),
                        Container(
                          height: 24.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(50)),
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                                child: Text(
                              AppStrings.change,
                              style: TextStyle(color: AppColors.primaryColor),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150.h,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              AppColors.blueDark,
                              AppColors.primaryColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Lottie.asset(
                                JsonManger.washButton,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppStrings.wash,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        AppStrings.drop,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    AppStrings.carWashAnyWhere,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: AppColors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        5,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Card(
                                child: SizedBox(
                                  height: 96.h,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Image.network(
                                            "https://firebasestorage.googleapis.com/v0/b/dropapp-ede3c.appspot.com/o/image%2010.png?alt=media&token=9d0095b7-f003-4e47-96ae-56750bc3a56c"),
                                        SizedBox(
                                          width: 16.0.w,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Maintaince Service",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                            ),
                                            SizedBox(
                                              height: 5.0.h,
                                            ),
                                            const Text(
                                                "Drop-by a certified service station"),
                                          ],
                                        )),
                                        const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 22,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                  const CategoryTitle(title: AppStrings.notifications),
                  SizedBox(
                    height: 20.h,
                  ),
                  Card(
                    child: SizedBox(
                      height: 97.h,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Free Wash",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(height: 5.h,),
                            const Text("3/5 Washes", ),
                            SizedBox(height: 5.h,),
                             LinearProgressIndicator(value: 0.60 , minHeight: 12,)

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
