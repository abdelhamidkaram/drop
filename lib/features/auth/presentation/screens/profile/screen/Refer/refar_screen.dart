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
    String refarCode = userInfo?.refarCode ?? AppStrings.appName;
    onShare() async {
      await Share.share("Hey friend, Here’s a FREE Carwash just for you! Use my referral code ${refarCode} while you’re checking out. Download Drop here: https://drop-eg.com/GetDrop");
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
                    title: AppStrings.myRefer,
                    isMyOrdersScreen: true,
                    height: 233),
                Column(
                  children: [
                    const SizedBox(
                      height: 180,
                    ),
                    Center(
                        child: Image.asset(
                      ImagesManger.refar,
                      height: 300,
                    )),
                    SizedBox(height: 25.h,),
                    Text(
                      AppStrings.get1FreeWash,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: AppColors.primaryColor, fontSize: 28.sp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppStrings.forEveryFriendYouRefer,
                      style: Theme.of(context).textTheme.displaySmall,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                             SizedBox(width: 15.w,),
                                Spacer(),
                                Text(
                                  refarCode,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          color: AppColors.grey.withOpacity(0.50),
                                          overflow: TextOverflow.ellipsis),
                                ),
                                Spacer(),
                                InkWell(
                                    hoverColor: AppColors.primaryColor,
                                    radius: 60,
                                    onTap: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: refarCode));
                                          EasyLoading.showSuccess("Copied" , );
                                    },
                                    child:  Icon(Icons.copy_outlined, size: 30 , color: AppColors.grey.withOpacity(0.50),)),
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
