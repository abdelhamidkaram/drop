part of 'topnotifications_cubit.dart';

abstract class TopNotificationsState extends Equatable {
  const TopNotificationsState();

  @override
  List<Object> get props => [];
}

class TopNotificationsInitial extends TopNotificationsState {}


class GetLastEventNotificationSuccess extends TopNotificationsState {}
class GetLastEventNotificationLoading extends TopNotificationsState {}
class GetLastEventNotificationError extends TopNotificationsState {}


class GetOrderNotificationSuccess extends TopNotificationsState {}
class GetOrderNotificationLoading extends TopNotificationsState {}
class GetOrderNotificationError extends TopNotificationsState {}

class GetAppointmentEventNotificationSuccess extends TopNotificationsState {}
class GetAppointmentEventNotificationLoading extends TopNotificationsState {}
class GetAppointmentEventNotificationError extends TopNotificationsState {}


class successRegisterSuccess extends TopNotificationsState {}
class successRegisterLoading extends TopNotificationsState {}
class successRegisterError extends TopNotificationsState {}

