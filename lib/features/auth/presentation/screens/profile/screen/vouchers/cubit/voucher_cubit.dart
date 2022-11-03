import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/features/auth/domain/entities/vouchers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherInitial());

  static VoucherCubit get(context) => BlocProvider.of(context);

  List<Voucher> vouchers = [];
  getVouchers() async {
    emit(GetVoucherLoading());
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.vouchers)
        .get()
        .then((value) {
      vouchers = value.docs.map((e) => Voucher.formJson(e.data())).toList();
      emit(GetVoucherSucsess(vouchers: vouchers));
    }).catchError((err) {
      debugPrint(err.toString());
     emit(GetVoucherError()); 
    });
  }
}
