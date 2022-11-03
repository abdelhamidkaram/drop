import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/widgets/tap_build_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_string.dart';
import '../../../../../../core/utils/assets_manger.dart';

class ProfileTapsBar extends StatelessWidget {
  const ProfileTapsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 70.h,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TapBuildItem(
            context: context,
            assetSvgIcon: IconsManger.orders,
            text: AppStrings.myOrders,
            onTab: () {
              Navigator.pushNamed(context, AppRouteStrings.myOrders);
            },
          ),
          TapBuildItem(
            context: context,
            assetSvgIcon: IconsManger.referrals,
            text: AppStrings.referrals,
            onTab: () {
              Navigator.pushNamed(context, AppRouteStrings.refar);
            },
          ),
          TapBuildItem(
              context: context,
              assetSvgIcon: IconsManger.vouchers,
              text: AppStrings.vouchers,
              onTab:  () {
              Navigator.pushNamed(context, AppRouteStrings.vouchers);
            },
              ),
        ]),
      ),
    );
  }

}


