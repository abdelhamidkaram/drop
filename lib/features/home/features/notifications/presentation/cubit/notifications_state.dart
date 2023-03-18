part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}


class NotificationsInitial extends NotificationsState {}


class GetCompleteOrderLoading extends NotificationsState {}


class GetCompleteOrderSuccess extends NotificationsState {}

class GetCompleteOrderError extends NotificationsState {}
