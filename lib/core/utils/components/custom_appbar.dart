import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
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
                    CustomBackButton(
                        onPressed: isEditAccountScreen
                            ? () async {
                                Navigator.pushReplacementNamed(
                                    context, AppRouteStrings.account);
                              }
                            : null),
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
                    (isAddCompoundsScreen ||
                            isEditAccountScreen ||
                            isMyOrdersScreen)
                        ? SizedBox(
                            height: 30.h,
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              isAddScreen
                                  ? const HelloThere(
                                      title: AppStrings.carDetails,
                                      subtitle:
                                          AppStrings.pleaseEnterYourCarDetails)
                                  : isVouchersScreen
                                      ? HelloThere(
                                          title:
                                              "${AppStrings.hey} ${ProfileCubit.get(context).userDetails?.name},",
                                          subtitle: AppStrings
                                              .hereAreYourEarnedVouchers,
                                        )
                                      : HelloThere(
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

  static Container homeAppBar({
    required BuildContext context,
    String? title,
    required VoidCallback onTap,
    String? helloTitle,
    String? hellosubTitle,
  }) =>
      Container(
        height: 233,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
              image: Image.asset(ImagesManger.backgroundAppbar).image,
              fit: BoxFit.fitWidth),
        ),
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
                    CustomMenuButton(
                      onTap: onTap,
                    ),
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
                        )
                      : SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: HelloThere(
                                title: helloTitle,
                                subtitle: hellosubTitle ?? ""),
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

  static Container appBarWithCard({
    required BuildContext context,
    String? title,
    String? subTitle,
    String? img,
  }) =>
      Container(
        height: 320,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
              image: Image.asset(ImagesManger.backgroundAppbar).image,
              fit: BoxFit.fitWidth),
        ),
        child: PreferredSize(
          preferredSize: const Size(double.infinity, 310),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.0.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    const CustomBackButton(),
                    const Spacer(),
                    Image.asset(
                      ImagesManger.logo,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  child: SizedBox(
                    height: 100.h,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    title ?? "",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  Text(
                                    subTitle ?? "",
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                            img != null
                                ? ImageNetworkWithCached(
                                    imgUrl: img, width: 85.w)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
