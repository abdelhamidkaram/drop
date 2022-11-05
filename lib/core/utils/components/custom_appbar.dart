import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/route/app_route.dart';
import '../../../features/auth/presentation/widgets/hello_there.dart';
import '../app_colors.dart';
import '../app_string.dart';
import '../assets_manger.dart';
import 'custom_back_button.dart';
import 'custom_menu_button.dart';

class CustomAppbars {
  static PreferredSize loginAppbar({
    required BuildContext context,
    String? title,
    bool isLocationScreen = false,
    bool isLoginScreen = false,
    bool isAddScreen = false,
    bool isAddCompoundsScreen = false,
    bool isEditAccountScreen = false,
    bool isMyOrdersScreen = false,
    bool isVouchersScreen = false,
  }) =>
      PreferredSize(
         preferredSize: const Size(double.infinity, 220),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
              color: AppColors.white,
              image: isLocationScreen
                  ? null
                  : DecorationImage(
                      image: Image.asset(ImagesManger.backgroundAppbar).image,
                      fit: BoxFit.fitWidth)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    CustomBackButton(onPressed: isEditAccountScreen ? () async {
                      Navigator.pushReplacementNamed(context, AppRouteStrings.account);
                    } : null ),
                    const Spacer(),
                    isAddCompoundsScreen
                        ? Image.asset(
                            ImagesManger.logo,
                            color: Colors.white,
                          )
                        : Text(isLocationScreen ? "" : title!,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: AppColors.white)),
                    const Spacer(),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (isAddCompoundsScreen || isEditAccountScreen || isMyOrdersScreen )
                        ?  SizedBox(
                            height: 30.h,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              isAddScreen
                                  ? const HelloThere(
                                      title: AppStrings.carDetails,
                                      subtitle: AppStrings.pleaseEnterYourCarDetails)
                                  :isVouchersScreen ? HelloThere(
                                          title: "${AppStrings.hey} ${ProfileCubit.get(context).userDetails?.name},",
                                          subtitle:AppStrings.hereAreYourEarnedVouchers,
                                          ): HelloThere(
                                      subtitle: isLoginScreen
                                          ? AppStrings.loginHere
                                          : AppStrings.pleaseCreateAccount),
                            ],
                          ),
                    const SizedBox(height: 33),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static Container homeAppBar(
          {
          required BuildContext context,
          String? title,
          required VoidCallback onTap,
          String? helloTitle ,
          String? hellosubTitle ,

          }) =>
      Container(
        height: 233,
        decoration: BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
                image: Image.asset(ImagesManger.backgroundAppbar).image ,
                fit: BoxFit.fitWidth),),
        child: PreferredSize(
          preferredSize: const Size(double.infinity, 233),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    CustomMenuButton(onTap: onTap,),
                    const Spacer(),
                    title == null
                        ? Image.asset(
                            ImagesManger.logo,
                            color: Colors.white,
                          )
                        : Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: AppColors.white)),
                    const Spacer(),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              const Spacer(),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              helloTitle == null
                ? SizedBox(
                height: 40.h,
                width: double.infinity,
              ): SizedBox(
                height: 45.h,
                width: double.infinity,
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: HelloThere(title: helloTitle, subtitle: hellosubTitle?? ""),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
                ],
              )
              
            ],
          ),
        ),
        
      );

}
