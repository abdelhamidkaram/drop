import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/pages/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropeg/injection_container.dart' as di;

class EventsTopNotificationsButton extends StatefulWidget {
  const EventsTopNotificationsButton({
    Key? key,
  }) : super(key: key);

  @override
  State<EventsTopNotificationsButton> createState() =>
      _EventsTopNotificationsButtonState();
}

class _EventsTopNotificationsButtonState
    extends State<EventsTopNotificationsButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNotificationsCubit, TopNotificationsState>(
      builder: (context, state) {
        var cubit = TopNotificationsCubit.get(context);
        if (cubit.eventEntity != null && cubit.showEvents()) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventScreen(event: cubit.eventEntity!),
                      ));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 110.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0),
                              child: SizedBox(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (cubit.eventEntity!).title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!.copyWith(
                                        fontSize: 16.sp

                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      (cubit.eventEntity!).details!,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      height: 28.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(50),
                                        border: Border.all(
                                            color: AppColors.red, width: 2),
                                      ),
                                      child: Center(
                                        child: Text(AppStrings.reserveNow,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    color: AppColors.red,
                                                    fontSize: 13.sp
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ImageNetworkWithCached(
                              height: 100.h,
                              width: 120.w,
                              imgUrl: (cubit.eventEntity!).imgUrl!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    di
                        .sl<AppPreferences>()
                        .setShowEvent(false )
                        .then((value) => null);

                    di
                        .sl<AppPreferences>()
                        .notShowEventAgain()
                        .then((value) => null);
                    setState(() {
                      cubit.changeEvent(false);
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.black,
                  )),
            ],
          );
        } else {
          return const SizedBox();
        }

      },
    );
  }
}
