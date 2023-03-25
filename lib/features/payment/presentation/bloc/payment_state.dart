part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}


class PaymentAuthTokenLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentAuthTokenSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentAuthTokenError extends PaymentState {
  final error ;
  PaymentAuthTokenError({required this.error});
  @override
  List<Object> get props => [error];
}


class PaymentGetOrderIdLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentGetOrderIdSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentGetOrderIdError extends PaymentState {
  final error ;
  PaymentGetOrderIdError({required this.error});
  @override
  List<Object> get props => [error];
}


class PaymentGetFinalTokenCardLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentGetFinalTokenCardSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentGetFinalTokenCardError extends PaymentState {
  final error ;
  PaymentGetFinalTokenCardError({required this.error});
  @override
  List<Object> get props => [error];
}


class PaymentCallBackLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentCallBackSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentCallBackError extends PaymentState {
  @override
  List<Object> get props => [];
}
