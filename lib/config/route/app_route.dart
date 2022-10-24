import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/login/login_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/profile_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/add_car_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/compounds_viwe.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/screens/onboarding/onbording_screen.dart';
import '../../features/auth/presentation/screens/profile/bloc/cubit.dart';
import '../../features/auth/presentation/screens/register/location/location_screen.dart';
import '../../features/auth/presentation/screens/welcome/welcome_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/splash.dart';
import 'package:dropeg/injection_container.dart' as di;

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
  static const String profile = "profile";
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
            return const LocationScreen();
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
          builder: (context) => const AddCarScreen(),
        );
      case AppRouteStrings.compounds:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<CompoundCubit>()..getCompounds(),
              child: const CompoundsScreen(),
            );
          },
        );
      case AppRouteStrings.profile:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => di.sl<ProfileCubit>()..profileDetails(),
              child: const ProfileScreen(),
            );
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
