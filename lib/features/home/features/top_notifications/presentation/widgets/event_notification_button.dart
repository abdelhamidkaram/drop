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
  bool isFristCall = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopNotificationsCubit, TopNotificationsState>(
      builder: (context, state) {
        var cubit = TopNotificationsCubit.get(context);
        if (cubit.eventEntity != null && cubit.showEvents()) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventScreen(event: cubit.eventEntity!),
                  ));
            },
            child: Column(
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
                                    ImageNetworkWithCached(
                                      height: 100.h,
                                      width: 120.h,
                                      imgUrl: (cubit.eventEntity!).imgUrl!,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: SizedBox(
                                  width: 250.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (cubit.eventEntity!).title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        (cubit.eventEntity!).details!,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        height: 28.h,
                                        width: 130.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: AppColors.red, width: 2),
                                        ),
                                        child: Center(
                                          child: Text(AppStrings.reserveNow,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: AppColors.red)),
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
                                    di
                                        .sl<AppPreferences>()
                                        .setShowEvent(false)
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
            ),
          );
        } else if (cubit.eventEntity == null &&
            cubit.showEvents() &&
            isFristCall) {
         
        } else {
          return const SizedBox();
        }
        return const SizedBox();
      },
    );
  }
}
