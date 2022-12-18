import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class RefarScreen extends StatelessWidget {
  const RefarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String refarCode =userInfo?.refarCode ?? AppStrings.appName;
    onShare() async {
      await Share.share(refarCode);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Stack(
          children: [
            CustomAppbars.loginAppbar(
              context: context,
              title: AppStrings.myRefar,
              isMyOrdersScreen: true,
              height: 233
            ),

            Column(
              children: [
                const SizedBox(height: 120,),
                Center(
            child: Image.asset(
          ImagesManger.refar,
          height: 320.h,
        )),
        Text(
          AppStrings.get1FreeWash,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: AppColors.primaryColor, fontSize: 28.sp),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          AppStrings.foreveryfriendyourefer,
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(
          height: 27.h,
        ),
        SizedBox(
          height: 63.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: refarCode));
                          EasyLoading.showToast(AppStrings.copied,
                              toastPosition: EasyLoadingToastPosition.bottom);
                        },
                        child: const Icon(Icons.copy, size: 37)),
                    SizedBox(
                      width: 25.w,
                    ),
                    Text(
                      refarCode,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: AppColors.grey,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 35.h,
        ),
        SizedBox(
          width: 200.w,
          child: AppButtonBlue(
            onTap: onShare,
            text: AppStrings.share,
          ),
        )
          
              ],
            )
          ],
        ),
        
          
          ],
        ),
      ),
    );
  }
}
