part of 'voucher_cubit.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

class VoucherInitial extends VoucherState {}

class GetVoucherLoading extends VoucherState {}

class GetVoucherSucsess extends VoucherState {
  final List<Voucher> vouchers;
  const GetVoucherSucsess({required this.vouchers}) : super();
}

class GetVoucherError extends VoucherState {}
