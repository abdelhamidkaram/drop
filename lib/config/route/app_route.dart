import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/login/login_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/Refer/refar_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/my_order/myorder/presentation/cubit/myorder_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/my_order/myorder/presentation/pages/my_order.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/profile_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/vouchers/vouchers_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/add_car_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/compounds_viwe.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/screens/onboarding/onbording_screen.dart';
import '../../features/auth/presentation/screens/profile/screen/edit_profile.dart';
import '../../features/auth/presentation/screens/register/location/location_screen.dart';
import '../../features/auth/presentation/screens/welcome/welcome_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/splash.dart';
import 'package:dropeg/injection_container.dart' as di;

import 'app_route_arguments.dart';

class AppRouteStrings {
  static const String initial = "/";
  static const String welcome = "welcome";
  static const String login = "login";
  static const String register = "register";
  static const String home = "home";
  static const String location = "location";
  static const String addCar = "addcar";
  static const String onBoarding = "onboarding";
  static const String compounds = "compounds";
  static const String account = "profile";
  static const String accountEdit = "profileEdit";
  static const String myOrders = "myOrders";
  static const String refar = "myRefar";
  static const String vouchers = "vouchers";
}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteStrings.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRouteStrings.login:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: const LoginScreen(),
            );
          },
        );
      case AppRouteStrings.register:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: const RegisterScreen(),
            );
          },
        );
      case AppRouteStrings.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppRouteStrings.welcome:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: const WelcomeScreen(),
            );
          },
        );
      case AppRouteStrings.location:
        return MaterialPageRoute(
          builder: (context) {
            LocationsArgs arg;
            try {
              arg = routeSettings.arguments as LocationsArgs;
            } catch (err) {
              arg = LocationsArgs(formProfileScreen: false);
            }
            return LocationScreen(
              formProfileScreen: arg.formProfileScreen,
              locationEntity: arg.locationEntity,
            );
          },
        );
      case AppRouteStrings.onBoarding:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: const OnBoardingScreen(),
            );
          },
        );
      case AppRouteStrings.addCar:
        return MaterialPageRoute(
          builder: (context) {
            bool arg = routeSettings.arguments != null
                ? routeSettings.arguments as bool
                : false;
            return AddCarScreen(formProfileScreen: arg);
          },
        );
      case AppRouteStrings.compounds:
        return MaterialPageRoute(
          builder: (context) {
            CompoundsViewArgs args =
                routeSettings.arguments as CompoundsViewArgs;
            return BlocProvider(
              create: (context) => di.sl<CompoundCubit>()..getCompounds(),
              child: CompoundsScreen(toAddCarScreen: args.toAddCarScreen),
            );
          },
        );
      case AppRouteStrings.account:
        return MaterialPageRoute(
          builder: (context) {
            di.sl<AppPreferences>().isProfileNotFristBuild().then((value) {
              if (!value) {
                di
                    .sl<ProfileCubit>()
                    .getProfileDetails(isRefresh: true)
                    .then((value) => null);
                    di
                    .sl<ProfileCubit>()
                    .getCars(isRefresh: true)
                    .then((value) => null);
                di
                    .sl<AppPreferences>()
                    .setProfileNotFristBuild()
                    .then((value) => null);
              }
            });
            return const ProfileScreen();
          },
        );
      case AppRouteStrings.accountEdit:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileEditScreen();
          },
        );
      case AppRouteStrings.myOrders:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => MyorderCubit()..getMyOrder(),
              child: const MyOrderScreen(),
            );
          },
        );
      case AppRouteStrings.refar:
        return MaterialPageRoute(
          builder: (context) {
            return const RefarScreen();
          },
        );
      case AppRouteStrings.vouchers:
        return MaterialPageRoute(
          builder: (context) {
            return const VouchersScreen();
          },
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.unDefinedRouteMSG),
        ),
      ),
    );
  }
}
