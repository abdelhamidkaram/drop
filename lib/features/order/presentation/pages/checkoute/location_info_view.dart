import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/location_icon.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/Order/presentation/widgets/order_time_type_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

class LocationInformationView extends StatelessWidget {
  const LocationInformationView({
    Key? key,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryTitle(title: AppStrings.locationInformation),
        SizedBox(
          height: 5.0.h,
        ),
        Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    SizedBox(
                      height: 25.h,
                      width: 25.h,
                      child: SvgPicture.asset(locationIcon(
                          OrderCubit.get(context).orderLocation?.type ??
                              AppStrings.locationTypeHome)),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          OrderCubit.get(context).orderLocation?.type ?? "Home",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          OrderCubit.get(context).orderLocation!.address ?? "",
                          maxLines: 2,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        )
                      ],
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    OrderTimeTypeWidget(
                      orderTimeType: OrderTimeType.rightNow,
                      orderCubit: orderCubit,
                      onTap: () {
                        orderCubit.changeOrderDateTime(
                          dateTime: DateTime.now(),
                          orderTimeType: OrderTimeType.rightNow,
                        );
                      },
                    ),
                    SizedBox(height: 5.0.h),
                    OrderTimeTypeWidget(
                      orderTimeType: OrderTimeType.schedule,
                      orderCubit: orderCubit,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                height: 350.h,
                                child: CalenderWidget(orderCubit: orderCubit),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    Key? key,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Container(
          height: 350.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 240.h,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TableCalendar(
                    shouldFillViewport: true,
                    currentDay: DateTime.parse(
                        orderCubit.orderDateTime ?? DateTime.now().toString()),
                    onDaySelected: (selectedDay, focusedDay) {
                      orderCubit.changeOrderDateTime(
                          dateTime: selectedDay,
                          orderTimeType: OrderTimeType.schedule);
                    },
                    weekendDays: const [],
                    firstDay: DateTime.utc(2020, 1, 14),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.parse(
                        orderCubit.orderDateTime ?? DateTime.now().toString()),
                    headerVisible: true,
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                      todayTextStyle: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: AppColors.white),
                      defaultTextStyle: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500),
                      disabledTextStyle: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500)),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      headerMargin: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                              showTimePiker(context);
                            },
                      child: Row(
                        children: [
                          Text(
                            AppStrings.time,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          Expanded(
                            child: Card(
                              child: SizedBox(
                                height: 30.h,
                                width: 100.w,
                                child: Center(
                                  child: Text(
                                      '${DateTime.parse(orderCubit.orderDateTime!).hour > 10 ? DateTime.parse(orderCubit.orderDateTime!).hour : '0${DateTime.parse(orderCubit.orderDateTime!).hour}'} : ${DateTime.parse(orderCubit.orderDateTime!).minute > 10 ? DateTime.parse(orderCubit.orderDateTime!).minute : '0${DateTime.parse(orderCubit.orderDateTime!).minute}'}'),
                                ),
                              ),
                            ),
                          ),
                          AppChangeButton(
                              text: AppStrings.change + AppStrings.time,
                              onTap: () {
                              showTimePiker(context);
                              })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppButtonBlue(
                        text: AppStrings.confirmTiming,
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showTimePiker(BuildContext context) {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        var year = int.tryParse(orderCubit
                .orderDateTime!
                .substring(0, 4)) ??
            2025;
        var month = int.tryParse(orderCubit
                .orderDateTime!
                .substring(5, 7)) ??
            00;
        var day = int.tryParse(orderCubit
                .orderDateTime!
                .substring(8, 9)) ??
            00;
        var currentDateAndTime = DateTime.tryParse(
            '$year-${month > 10 ? '$month' : '0$month'}-${day> 10 ? '$day' : '0$day'} ${value.hour > 10 ? value.hour : '0${value.hour}'  }:${value.minute > 10 ? value.minute : '0${value.minute}'}:00');
        orderCubit.changeOrderDateTime(
            dateTime: currentDateAndTime ?? DateTime.now(),
            orderTimeType: OrderTimeType.schedule);
        
      }
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }
}
