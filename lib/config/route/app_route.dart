import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/login/login_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/Refer/refar_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/my_order/myorder/presentation/cubit/myorder_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/my_order/myorder/presentation/pages/my_order.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/profile_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/vouchers/vouchers_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/add_car_screen.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_cuibt.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/compounds_viwe.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_screen.dart';
import 'package:dropeg/features/confirm%20order/presentation/pages/confirm_order_screen.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:dropeg/features/home/features/services/presentation/screens/appointment_order_confirmed_sreen.dart';
import 'package:dropeg/features/home/features/services/presentation/screens/schedule_appointment.dart';
import 'package:dropeg/features/home/features/services/presentation/screens/sigle_provider_services_screen.dart';
import 'package:dropeg/features/home/features/services/presentation/screens/single_provider_screen.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:dropeg/features/order/presentation/pages/checkoute/free_order_screen.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/screens/onboarding/onbording_screen.dart';
import '../../features/auth/presentation/screens/profile/screen/edit_profile.dart';
import '../../features/auth/presentation/screens/register/location/location_screen.dart';
import '../../features/auth/presentation/screens/welcome/welcome_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/order/presentation/pages/checkoute/check_out_screen.dart';
import '../../features/order/presentation/pages/order_services/intror_screen.dart';
import '../../features/order/presentation/pages/order_services/order_main_screen.dart';
import '../../features/splash/splash.dart';
import 'package:dropeg/injection_container.dart' as di;

import 'app_route_arguments.dart';

class AppRouteStrings {
  static const String initial = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String location = "/location";
  static const String addCar = "/addcar";
  static const String onBoarding = "/onboarding";
  static const String compounds = "/compounds";
  static const String account = "/profile";
  static const String accountEdit = "/profile/profileEdit";
  static const String myOrders = "/profile/myOrders";
  static const String refar = "/profile/myRefar";
  static const String vouchers = "/profile/vouchers";
  static const String singleProvider = "/services/single";
  static const String singleProviderServices = "/services/single/services";
  static const String singleProviderScheduleAppointment =
      "/services/single/services/schedule";
  static const String singleProviderOrderConfirmed =
      "/services/single/services/schedule/orderconfirmed";

  static const String order = "/Order";
  static const String interior = "/Order/interior";
  static const String checkOut = "/Order/CheckOut";
  static const String freeOrder = "/Order/freeOrder";
  static const String confirmOrder = "/Order/confirmOrder";
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
            return const LoginScreen();
          },
        );
      case AppRouteStrings.register:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => TopNotificationsCubit()),
              ],
              child: const RegisterScreen(),
            );
          },
        );
      case AppRouteStrings.home:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => di.sl<HomeCubit>()..getServices()),
              ],
              child: const HomeScreen(),
            );
          },
        );
      case AppRouteStrings.welcome:
        return MaterialPageRoute(
          builder: (context) {
            return const WelcomeScreen();
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
        return authRoute(screen: const ProfileScreen());
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
      case AppRouteStrings.singleProvider:
        var args = routeSettings.arguments as SingleProviderArgs;
        return MaterialPageRoute(
          builder: (context) =>
              SingleProviderScreen(serviceEntity: args.serviceEntity),
        );
      case AppRouteStrings.singleProviderServices:
        var args = routeSettings.arguments as SingleProviderServicesArgs;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProviderServicesCubit(),
            child: SingleProviderServicesScreen(
              serviceEntity: args.serviceEntity,
              index: args.index,
            ),
          ),
        );
      case AppRouteStrings.singleProviderScheduleAppointment:
        var args = routeSettings.arguments as ScheduleAppointmentArgs;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => ProviderServicesCubit()
                ..changeSelectedProvider(
                    args.serviceEntity.serviceProviders[args.index]),
              child: ScheduleAppointmentScreen(
                serviceEntity: args.serviceEntity,
                index: args.index,
                serviceProvideList: args.serviceProvideList,
              ),
            );
          },
        );
      case AppRouteStrings.singleProviderOrderConfirmed:
        var arg = routeSettings.arguments as SingleProviderOrderConfirmedArgs;
        return MaterialPageRoute(
          builder: (context) {
            return SingleProviderOrderConfirmedScreen(
                serviceProvideList: arg.serviceProvideList);
          },
        );
      case AppRouteStrings.confirmOrder:
        var arg = routeSettings.arguments as ConfirmOrderArgs;
        return MaterialPageRoute(
          builder: (context) {
            return ConfirmOrderScreen(
              order: arg.order,
              grandTotal: arg.grandTotal,
              vat: arg.vat,
            );
          },
        );

      case AppRouteStrings.order:
        var arg = routeSettings.arguments as OrderMainArgs;
        return authRoute(screen: OrderMainScreen(location: arg.locationEntity));
      case AppRouteStrings.checkOut:
        return MaterialPageRoute(
          builder: (context) => const CheckOutScreen(),
        );
      case AppRouteStrings.freeOrder:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (context) =>
                di.sl<HomeCubit>()..getMainLocation(context: context),
            child: FreeOrderScreen(),
          ),
        );
      case AppRouteStrings.interior:
        var arg = routeSettings.arguments as OrderMainArgs;
        return MaterialPageRoute(
          builder: (context) => InteriorScreen(location: arg.locationEntity),
        );

      default:
        return undefinedRoute();
    }
  }

  static authRoute({required Widget screen}) {
    if (userInfo != null) {
      return MaterialPageRoute(
        builder: (context) => screen,
      );
    } else {
      AppToasts.errorToast(AppStrings.requiredLogin);
      return MaterialPageRoute(
        builder: (context) {
          return const WelcomeScreen();
        },
      );
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
