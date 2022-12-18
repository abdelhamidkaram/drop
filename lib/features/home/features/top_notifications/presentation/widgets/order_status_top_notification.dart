import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:dropeg/injection_container.dart' as di;
import '../../../../../../core/shared_prefs/app_prefs.dart';

class OrderStatusTopNotificationsButton extends StatefulWidget {
  const OrderStatusTopNotificationsButton({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderStatusTopNotificationsButton> createState() =>
      _OrderStatusTopNotificationsButtonState();
}

class _OrderStatusTopNotificationsButtonState
    extends State<OrderStatusTopNotificationsButton> {
  bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNotificationsCubit, TopNotificationsState>(
      builder: (context, state) {
        if (TopNotificationsCubit.get(context).showOrder()) {
          return Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: 110.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  const Spacer(),
                                  LottieBuilder.asset(
                                      JsonManger.checkStatusButton,
                                      width: 150.w),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                width: 165.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      AppStrings.youHaveWashDrop,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      height: 28.h,
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              AppRouteStrings.myOrders);
                                        },
                                        child: Center(
                                          child: Text(AppStrings.checkStatus,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isOpen = false;
                                  });
                                  di
                                      .sl<AppPreferences>()
                                      .setShowOrderTopNotification(false);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.black,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
