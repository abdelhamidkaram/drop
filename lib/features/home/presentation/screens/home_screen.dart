import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/drawer.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/home/bloc/home_states.dart';
import 'package:dropeg/features/home/features/services/presentation/screens/services_view.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/location_show.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/pages/top_notifications_view.dart';
import 'package:dropeg/features/home/presentation/widgets/main_location.dart';
import 'package:dropeg/features/home/presentation/widgets/main_btn.dart';
import 'package:dropeg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropeg/injection_container.dart' as di;
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    HomeCubit.get(context).getMainLocation(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocationEntity? location = HomeCubit.get(context).mainLocation;
    List<LocationEntity>? locations = ProfileCubit.get(context).locations;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        key: homeScaffoldStateKey,
        drawer: drawer(
          context: context,
          drawerSelected: DrawerSelected.home,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbars.homeAppBar(
                  context: context,
                  helloTitle: "${AppStrings.hello} ${userInfo?.nameForView ?? ''},",
                  hellosubTitle: AppStrings.welcomeBack,
                  onTap: () {
                    homeScaffoldStateKey.currentState?.openDrawer();
                  }),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 20.0),
                child: locations != null
                    ? MainLocation(
                  onTap: () {
                    if (location != null) {
                      showLocationChoose(
                        homeScaffoldStateKey: homeScaffoldStateKey,
                        location: location,
                        locations: locations,
                      );
                    }
                  },
                )
                    : null,
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) => di.sl<HomeCubit>(),
                builder: (context, state) {
                  var location = HomeCubit.get(context).mainLocation;
                  return MainButton(
                      location: location ??
                          LocationEntity(
                            address: "address",
                            state: "state",
                            city: "city",
                            type: "Home",
                            id: "id",
                          ));
                },
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const TopNotificationsView(),
                    const ServicesListView(),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CategoryTitle(title: AppStrings.notifications),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Notifications()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLocationChoose(
      {required List<LocationEntity> locations,
      required LocationEntity location,
      required GlobalKey<ScaffoldState> homeScaffoldStateKey}) {
    homeScaffoldStateKey.currentState!.showBottomSheet((context) => BottomSheet(
          elevation: 100,
          enableDrag: false,
          onClosing: () {},
          builder: (context) => Container(
            height: 330.h,
            decoration: BoxDecoration(
                boxShadow: const [BoxShadow()],
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                LocationsShow(
                  locations: locations,
                  currentLocation: location,
                ),
              ],
            ),
          ),
        ));
  }
}

class Notifications extends StatelessWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser?.uid == null ? Future(() => 0) : FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
          return value.get("freeWashUsed") ;
        }).catchError((err){
          debugPrint(err.toString());
          return 0;
        }),
        builder: (context, snapshot) => InkWell(
          onTap: (){

            if(snapshot.data == 5 ){
              Navigator.pushNamed(context, AppRouteStrings.freeOrder);
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: BorderSide(
                color: snapshot.data == 5 ? AppColors.primaryColor : AppColors.greyBorder,

              )
            ),
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
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "${snapshot.data ?? 0}/${userInfo?.freeWashTotal ?? 5} Washes",
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  LinearPercentIndicator(
                    width: 280.w,
                    lineHeight: 10.0.h,
                    percent: (snapshot.data as int? ?? 0 ) /
                        (userInfo?.freeWashTotal ?? 5),
                    backgroundColor: AppColors.greyBorder,
                    progressColor: AppColors.primaryColor,
                    barRadius: const Radius.circular(25),
                  ),
                ],
              ),
            ),
          ),),
        )
    );
  }
}
