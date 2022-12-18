import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/firestore_strings.dart';
import '../../../../../Order/domain/entities/orders.dart';
import '../../domain/entities/event.dart';
import 'package:dropeg/injection_container.dart' as di;
part 'topnotifications_state.dart';

class TopNotificationsCubit extends Cubit<TopNotificationsState> {
  TopNotificationsCubit() : super(TopNotificationsInitial());
  static TopNotificationsCubit get(context) => BlocProvider.of(context);
  AppPreferences appPreferences = di.sl<AppPreferences>();

  bool showEvents() => appPreferences.isShowEvent();
  bool showOrder() => appPreferences.isShowOrderTopNotification();
  bool showAppointment() => appPreferences.isShowAppointmentTopNotification();

  EventEntity? eventEntity;
  Future getLastEvent({EventEntity? event}) async {
    if (eventEntity == null) {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.eventsCollection)
          .get()
          .then((value) {
        eventEntity = EventEntity.fromJson(value.docs.first.data());
        changeEvent(true);
      }).catchError((err) {
        debugPrint(err.toString());
        emit(GetLastEventNotificationError());
      });
    }
  }

  changeEvent(bool value) async {
    emit(GetLastEventNotificationLoading());
    await appPreferences.setShowEvent(value);
    emit(GetLastEventNotificationSuccess());
  }

  /////////////////////////////// order

  OrderEntity? order;
  bool noOrder = false;

  changeOrder(bool value) async {
    emit(GetOrderNotificationLoading());
    await appPreferences.setShowOrderTopNotification(value);
    emit(GetOrderNotificationSuccess());
  }

  /////////////////////////////// appointment

  Map<String, dynamic>? appointment;
  bool noAppointment = false;
  Future getLastAppomintment() async {
    if (appointment == null && userInfo != null && !noAppointment) {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.appointmentsList)
          .where("userId", isEqualTo: userInfo!.id)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          appointment = value.docs.first.data();
        } else {
          noAppointment = true;
        }
      }).catchError((err) {
        debugPrint(err.toString());
        emit(GetAppointmentEventNotificationError());
      });
    }
  }

  changeAppointment(bool value) async {
    emit(GetAppointmentEventNotificationLoading());
    await appPreferences.setShowAppointmentTopNotification(value);
    emit(GetAppointmentEventNotificationSuccess());
  }
}
