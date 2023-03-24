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
