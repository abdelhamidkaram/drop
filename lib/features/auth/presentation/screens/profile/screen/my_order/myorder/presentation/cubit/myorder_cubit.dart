import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/features/auth/domain/entities/orders.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'myorder_state.dart';

class MyorderCubit extends Cubit<MyorderStates> {
  MyorderCubit() : super(MyorderInitial());
  static MyorderCubit get(context) => BlocProvider.of(context);
  List<Order> orders = [];

  getMyOrder() async {
    emit(GetMyorderloading());
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.ordersCollection)
        .get()
        .then((value) {
      orders = value.docs.map((e) => Order.fromJson(e.data())).toList();
      emit(GetMyordersuccess());
    }).catchError((err) {
      debugPrint(err.toString());
      emit(GetMyorderError());
    });
  }


}
