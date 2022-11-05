import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/drawer.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/home/data/models/service_model.dart';
import 'package:dropeg/features/home/presentation/bloc/home_cubit.dart';
import 'package:dropeg/features/home/presentation/bloc/home_states.dart';
import 'package:dropeg/features/home/presentation/widgets/main_btn.dart';
import 'package:dropeg/features/home/presentation/widgets/main_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

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
    LocationEntity? location = ProfileCubit.get(context).locations?[0];
    List<LocationEntity>? locations = ProfileCubit.get(context).locations;
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
              child: location != null
                  ? MainLocation(
                      onTap: () {
                        if (locations != null) {
                          homeScaffoldStateKey.currentState!
                              .showBottomSheet((context) => BottomSheet(
                                elevation: 100,
                                     enableDrag: false,
                                    onClosing: () {},
                                    builder: (context) => Container(
                                      height: 330.h,
                                      decoration: BoxDecoration(
                                        boxShadow:const [BoxShadow()],
                                          color: AppColors.white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(22),
                                            topRight: Radius.circular(22),
                                          )),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10.h,),
                                          LocationsShow(
                                              locations: locations,
                                              currentLocation: location , 
                                              
                                            ),
                                        ],
                                      ),
                                    ),
                                  ));
                        }
                      },
                    )
                  : null,
            ),
            SizedBox(
              height: 10.h,
            ),
            const MainButton(),
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
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text(
                              "3/5 Washes",
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const LinearProgressIndicator(
                                  value: 0.60,
                                  minHeight: 12,
                                ))
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

class LocationsShow extends StatefulWidget {
  final List<LocationEntity> locations;
  final LocationEntity currentLocation;

  const LocationsShow(
      {super.key, required this.locations, required this.currentLocation});

  @override
  State<LocationsShow> createState() => _LocationsShowState();
}

class _LocationsShowState extends State<LocationsShow> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => HomeCubit(),
      listenWhen: (previous, current) => current is GetMainLocationSuccess,
      builder: (context, state) {
        var location = widget.currentLocation;
        return SizedBox(
          height: 320.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 15.h,
              ),
              itemCount: widget.locations.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  HomeCubit.get(context).getMainLocation(
                      context: context, location: widget.locations[index]);
                  location = widget.locations[index];
                  if(Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                },
                child: Card(
                  color: widget.locations[index] ==
                          HomeCubit.get(context).mainLocation
                      ? AppColors.primaryColor
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.locations[index].type ?? "",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(widget.locations[index].address ?? ""),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
