
import 'package:dropeg/features/home/features/top_notifications/presentation/cubit/topnotifications_cubit.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/widgets/appointment_top_notification.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/widgets/event_notification_button.dart';
import 'package:dropeg/features/home/features/top_notifications/presentation/widgets/order_status_top_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isFirstBuild = true;

class TopNotificationsView extends StatefulWidget {
  const TopNotificationsView({super.key});

  @override
  State<TopNotificationsView> createState() => _TopNotificationsViewState();
}

class _TopNotificationsViewState extends State<TopNotificationsView> {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TopNotificationsCubit, TopNotificationsState>(
      listener: (context, state) => TopNotificationsCubit(),
      builder: (context, state) {
        return Column(
          children: const [
            EventsTopNotificationsButton(),
           OrderStatusTopNotificationsButton(),
            AppointmentTopNotificationButton(),
          ],
        );
      },
    );
  }
}
