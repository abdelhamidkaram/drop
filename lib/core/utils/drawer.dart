import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_string.dart';
import 'components/profile_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Drawer drawer(
    {required BuildContext context, required DrawerSelected drawerSelected}) {
  return Drawer(
    child: BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) => ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteStrings.account);
                  },
                  child: userInfo != null
                      ? const ProfileHeader()
                      : const SizedBox(),
                ),
              ],
            )),
          ),
          ListTile(
            shape: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: drawerSelected == DrawerSelected.home
                        ? AppColors.primaryColor
                        : Colors.grey.shade300)),
            title: Text(
              AppStrings.home,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: drawerSelected == DrawerSelected.home
                      ? AppColors.primaryColor
                      : null),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouteStrings.home);
            },
            leading: drawerSelected == DrawerSelected.home
                ? SvgPicture.asset(IconsManger.homeIcon,
                    color: AppColors.primaryColor)
                : SvgPicture.asset(IconsManger.homeIcon, color: AppColors.black),
          ),
          ListTile(
            shape: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: drawerSelected == DrawerSelected.account
                        ? AppColors.primaryColor
                        : Colors.grey.shade300)),
            style: ListTileStyle.list,
            title: Text(
              AppStrings.account,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: drawerSelected == DrawerSelected.account
                      ? AppColors.primaryColor
                      : null),
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRouteStrings.account);
            },
            leading: drawerSelected == DrawerSelected.account
                ? SvgPicture.asset(IconsManger.account,
                    color: AppColors.primaryColor)
                : SvgPicture.asset(IconsManger.account, color: AppColors.black),
          ),
          ListTile(
            shape: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: drawerSelected == DrawerSelected.help
                        ? AppColors.primaryColor
                        : Colors.grey.shade300)),
            style: ListTileStyle.list,
            title: Text(
              AppStrings.help,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: drawerSelected == DrawerSelected.help
                      ? AppColors.primaryColor
                      : null),
            ),
            onTap: () {},
            leading: drawerSelected == DrawerSelected.help
                ? SvgPicture.asset(IconsManger.account,
                    color: AppColors.primaryColor)
                : SvgPicture.asset(IconsManger.help, color: AppColors.black),
          ),
          ListTile(
            shape: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey.shade300)),
            style: ListTileStyle.list,
            title: Text(
              AppStrings.logOut,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: drawerSelected == DrawerSelected.help
                      ? AppColors.primaryColor
                      : null),
            ),
            onTap: ()   {
              ProfileCubit.get(context).logOut(context);
            },
            leading: Icon(Icons.logout , color: AppColors.black,),

          ),
        ],
      ),
    ),
  );
}
