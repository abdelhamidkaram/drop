part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}


class GetOrderLocationLoading extends OrderState {}
class GetOrderLocationSuccess extends OrderState {}


class ChangeCarSelectedLoading extends OrderState {}
class ChangeCarSelectedSuccess extends OrderState {}

class ChangeOrderTimeLoading extends OrderState {}
class ChangeOrderTimeSuccess extends OrderState {}


class ChangePaymentTypeLoading extends OrderState {}
class ChangePaymentTypeSuccess extends OrderState {}

class AddInteriorSelectedLoading extends OrderState {}
class AddInteriorSelectedSuccess extends OrderState {}

class RemoveInteriorSelectedLoading extends OrderState {}
class RemoveInteriorSelectedSuccess extends OrderState {}

class GetRequiredServicesLoading extends OrderState {}
class GetRequiredServicesError extends OrderState {}
class GetRequiredServicesSuccess extends OrderState {}


class SetOrderToServerLoading extends OrderState {}
class SetOrderToServerError extends OrderState {}
class SetOrderToServerSuccess extends OrderState {}

class AddServicesLoading extends OrderState {}
class AddServicesSuccess extends OrderState {}
class AddServicesError extends OrderState {}

class RemoveServicesLoading extends OrderState {}
class RemoveServicesError extends OrderState {}
class RemoveServicesSuccess extends OrderState {}

class GetPromoCodeLoading extends OrderState {}
class GetPromoCodeError extends OrderState {}
class GetPromoCodeSuccess extends OrderState {}

class GetEssentialLoading extends OrderState {}
class GetEssentialError extends OrderState {}
class GetEssentialSuccess extends OrderState {}


class AddEssentialToSelectedLoading extends OrderState {}
class AddEssentialToSelectedSuccess extends OrderState {}

class RemoveEssentialToSelectedLoading extends OrderState {}
class RemoveEssentialToSelectedSuccess extends OrderState {}


