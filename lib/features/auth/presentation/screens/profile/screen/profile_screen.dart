import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/add_car_button.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/add_location_button.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/car_card_item.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/compound_card_item.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/location_card_item.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/profile_taps_bar.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/route/app_route.dart';
import '../../../../../../core/utils/components/category_title.dart';
import '../../../../../../core/utils/components/profile_header.dart';
import '../../../../../../core/utils/drawer.dart';
import '../../../../domain/entities/car.dart';
import '../../../../domain/entities/compound.dart';
import '../../../../domain/entities/location.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import 'package:dropeg/injection_container.dart' as di;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> profileScaffoldStateKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getCars().then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(AppRouteStrings.home);
        return Future.value(true);
      },
      child: BlocListener<ProfileCubit, ProfileStates>(
        listener: (context, state) => di.sl<ProfileCubit>(),
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          bloc: di.sl<ProfileCubit>(),
          builder: (context, state) {
            var profileCubit = ProfileCubit.get(context);
            List<LocationEntity> locations = profileCubit.locations ?? [];
            List<Compound> compounds = profileCubit.compounds ?? [];
            List<Car> cars = profileCubit.cars ?? [];
            Widget profileBody() {
              if (state is GetProfileDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is GetProfileDetailsError) {
                return Center(
                  child: Text(state.msg),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
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
                                  profileScaffoldStateKey.currentState!
                                      .openDrawer();
                                }),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRouteStrings.accountEdit);
                                    },
                                    child: BlocListener<ProfileCubit,
                                        ProfileStates>(
                                      listener: (context, state) =>
                                          di.sl<ProfileCubit>(),
                                      child: const ProfileHeader(
                                        isProfileScreen: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => profileCubit.refreshData(),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const ProfileTapsBar(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                const CategoryTitle(
                                    title: AppStrings.myLocations),
                                const SizedBox(
                                  height: 16,
                                ),
                                BlocListener<ProfileCubit, ProfileStates>(
                                    listener: (context, state) =>
                                        di.sl<ProfileCubit>(),
                                    child: BlocBuilder<ProfileCubit,
                                        ProfileStates>(
                                      builder: (context, state) {
                                        List<Widget>? compoundsView =
                                            List.generate(
                                          compounds.length,
                                          (index) => CompoundCardItem(
                                            index: index,
                                            compounds: compounds,
                                            setStateFun: () {
                                              setState(() {
                                                
                                              });
                                            },
                                          ),
                                        );
                                        List<Widget>? locationsView =
                                            List.generate(
                                                locations.length,
                                                (index) => LocationCardItem(
                                                      index: index,
                                                      locations: locations,
                                                    ));
                                        if (state is GetCompoundsSuccess) {
                                          if (state.compounds != null) {
                                            compoundsView = List.generate(
                                              state.compounds!.length,
                                              (index) => CompoundCardItem(
                                                index: index,
                                                compounds:
                                                    state.compounds ?? [],
                                              ),
                                            );
                                          } else {
                                            compoundsView = [];
                                          }
                                        }
                                        if (state is GetLocationsSuccess) {
                                          if (state.locations != null) {
                                            locationsView = List.generate(
                                                state.locations!.length,
                                                (index) => LocationCardItem(
                                                      index: index,
                                                      locations:
                                                          state.locations ?? [],
                                                    ));
                                          } else {
                                            locationsView = [];
                                          }
                                        }
                                        return Column(
                                          children: [
                                            Column(children: compoundsView),
                                            Column(children: locationsView),
                                          ],
                                        );
                                      },
                                    )),
                                AddLocationButton(profileCubit: profileCubit),
                                SizedBox(
                                  height: 20.h,
                                ),
                                const CategoryTitle(title: AppStrings.myCars),
                                SizedBox(
                                  height: 16.h,
                                ),
                                BlocListener<ProfileCubit, ProfileStates>(
                                    listener: (context, state) =>
                                        di.sl<ProfileCubit>(),
                                    child: BlocBuilder<ProfileCubit,
                                        ProfileStates>(
                                      builder: (context, state) {
                                        List<Widget>? carsView = List.generate(
                                          cars.length,
                                          (index) => CarCardItem(
                                            scaffoldKey:
                                                profileScaffoldStateKey,
                                            profileCubit: profileCubit,
                                            index: index,
                                          ),
                                        );
                                        if (state is GetCarsSuccess) {
                                          if (state.cars != null) {
                                            carsView = List.generate(
                                              state.cars?.length ?? 0,
                                              (index) => CarCardItem(
                                                scaffoldKey:
                                                    profileScaffoldStateKey,
                                                profileCubit: profileCubit,
                                                index: index,
                                              ),
                                            );
                                          } else {
                                            carsView = [];
                                          }
                                        }
                                        return Column(
                                          children: carsView,
                                        );
                                      },
                                    )),
                                const AddCarButton()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await profileCubit.getProfileDetails(isRefresh: true);
                },
              ),
              key: profileScaffoldStateKey,
              drawer: drawer(
                  drawerSelected: DrawerSelected.account, context: context),
              body: profileBody(),
            );
          },
        ),
      ),
    );
  }
}
