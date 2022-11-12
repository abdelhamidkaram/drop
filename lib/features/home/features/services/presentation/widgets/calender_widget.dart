import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/features/home/features/services/presentation/cubit/provider_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ProviderServicesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: TableCalendar(
        shouldFillViewport: true,
        currentDay: DateTime.parse(cubit.selectedTime),
        onDaySelected: (selectedDay, focusedDay) {
          cubit.changeSelectedTime(selectedDay);
        },
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.parse(cubit.selectedTime),
        headerVisible: true,
        weekendDays: [],
        calendarStyle: CalendarStyle(
          todayDecoration:
              BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
          todayTextStyle: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: AppColors.primaryColor),
          defaultTextStyle: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
          disabledTextStyle: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: AppColors.grey, fontWeight: FontWeight.w500),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppColors.white, fontWeight: FontWeight.w500)),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
          leftChevronVisible: false,
          rightChevronVisible: false,
          headerMargin: const EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }
}
