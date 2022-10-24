import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components/profile_header.dart';
import '../../../../../core/utils/drawer.dart';
import '../register/location/bloc/cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> profileScaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<LocationEntity> locations = [
      LocationEntity(
          address: "address1", state: "state1", city: "city1", type: "Home"),
      LocationEntity(
          address: "address2", state: "state2", city: "city2", type: "Office"),
      LocationEntity(
          address: "address3", state: "state3", city: "city3", type: "Other"),
    ];
    return Scaffold(
      key: profileScaffoldStateKey,
      drawer: drawer(drawerSelected: DrawerSelected.account, context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomAppbars.homeAppBar(
                        context: context,
                        title: AppStrings.account,
                        onTap: () {
                          profileScaffoldStateKey.currentState!.openDrawer();
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          ProfileHeader(
                            isProfileScreen: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                    profileTopBar(context),
                const SizedBox(
                  height: 25,
                ),
                title(context: context, title: AppStrings.myLocations),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: List.generate(locations.length, (index) =>
                      Row(
                        children: [
                          SizedBox(
                            height: 65.h,
                            width: 65.h,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1000)),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      locationIcon(locations[index].type!),
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Youssef Elhossary",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline3,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("+20 0103 32 328 03 "),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      )),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 65.h,
                      width: 65.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000)),
                        child: Center(
                          child: Icon(
                            Icons.add, color: AppColors.primaryColor,),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Youssef Elhossary",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("+20 0103 32 328 03 "),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                  ],
                )
          ],
        ),
      )
      ],
    ),)
    ,
    );
  }

  String locationIcon(String type) {
    switch (type) {
      case AppStrings.locationTypeHome :
        return IconsManger.locationHome;
      case AppStrings.locationTypeOffice :
        return IconsManger.locationOffice;
      default :
        return IconsManger.locationOffice;
    }
  }

  Row title({required BuildContext context, required String title}) {
    return Row(
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .headline3,
        ),
        const Spacer()
      ],
    );
  }

  Card profileTopBar(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(IconsManger.orders),
                Text(
                  AppStrings.myOrders,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(IconsManger.referrals),
                Text(
                  AppStrings.referrals,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(IconsManger.vouchers),
                Text(
                  AppStrings.vouchers,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
