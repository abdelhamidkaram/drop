import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/theme/app_theme.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/confirm%20order/presentation/cubit/confirm_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'features/auth/presentation/screens/profile/bloc/state.dart';
import 'features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'features/payment/presentation/bloc/payment_cubit.dart';
import 'package:dropeg/injection_container.dart' as di;

class DropApp extends StatelessWidget {
  const DropApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          bool isFirstBuild = true;
          di.sl<AppPreferences>().isOnBoardingScreenViewed()
              .then((value) =>isFirstBuild = value);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<AuthCubit>(),),
              BlocProvider(
                create: (context) =>
                di.sl<ProfileCubit>()
                  ..getProfileDetails(firstbuild: true)
                  ..getLocations()
                  ..getCars()
                  ..getCompounds(),
              ),
              BlocProvider(
                create: (context) =>
                OrderCubit()
                  ..getRequiredServices()
                  ..getEssential(),
              ),
              BlocProvider(create:
                  (context) => ConfirmOrderCubit(),
              ),
              BlocProvider(
                create: (context) =>
                TopNotificationsCubit()
                  ..getLastEvent(isFirstBuild:di.sl<AppPreferences>().isShowEvent())
                  ..getLastAppomintment(),),
              BlocProvider(create: (context) => PaymentCubit(),),
            ],
            child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) =>
              di.sl<ProfileCubit>()
                ..getProfileDetails(),
              builder: (context, state) =>
                  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: AppStrings.appName,
                    theme: appTheme(),
                    onGenerateRoute: AppRoute.onGenerateRoute,
                    builder: EasyLoading.init(builder: (context, child) {
                      return MediaQuery(
                        child: child!,
                        data: MediaQuery.of(context).copyWith(
                            textScaleFactor: 1.0),
                      );
                    }),


                  ),
            ),
          );
        }
    );
  }
}
