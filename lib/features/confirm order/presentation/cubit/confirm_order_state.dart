part of 'confirm_order_cubit.dart';

abstract class ConfirmOrderState extends Equatable {
  const ConfirmOrderState();
  @override
  List<Object> get props => [];
}

class ConfirmOrderInitial extends ConfirmOrderState {}

class ChangeOrderStatusSuccess extends ConfirmOrderState {}
class ChangeOrderStatusLoading extends ConfirmOrderState {}
class ChangeOrderStatusError extends ConfirmOrderState {}


