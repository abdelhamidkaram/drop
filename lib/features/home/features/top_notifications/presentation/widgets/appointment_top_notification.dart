import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/injection_container.dart' as di;

class AppointmentTopNotificationButton extends StatefulWidget {
  const AppointmentTopNotificationButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentTopNotificationButton> createState() =>
      _AppointmentTopNotificationButtonState();
}

class _AppointmentTopNotificationButtonState
    extends State<AppointmentTopNotificationButton> {
  bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNotificationsCubit, TopNotificationsState>(
      builder: (context, state) {
        var cubit = TopNotificationsCubit.get(context);
        if (cubit.appointment != null && cubit.showAppointment()) {
          Map<String, dynamic> data = cubit.appointment!;
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ImageNetworkWithCached(
                                        width: 100.h,
                                        height: 100.h,
                                        imgUrl: data["services"]["img"]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                width: 250.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "You have an appointment on ${data['appointment'].toString().substring(0, 10)}, with",
                                      maxLines: 2,
                                    ),
                                    Text(
                                      data['provider']['title'],
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: SizedBox(
                                                      height: 300.h,
                                                      child: ListView(
                                                        children: [
                                                          Text(
                                                            AppStrings.provider,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(data['provider']
                                                                  ['title'] ??
                                                              ""),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            AppStrings.date,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(data['appointment']
                                                                  ?.toString()
                                                                  .substring(
                                                                      0, 10) ??
                                                              ""),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            AppStrings.price,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(data['price'] ??
                                                              ""),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            AppStrings.comment,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                              data['comment'] ??
                                                                  ""),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: AppColors.black, width: 2),
                                        ),
                                        child: Center(
                                          child: Text(AppStrings.checkDetails,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  )),
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
                                      .setShowAppointmentTopNotification(false);
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
