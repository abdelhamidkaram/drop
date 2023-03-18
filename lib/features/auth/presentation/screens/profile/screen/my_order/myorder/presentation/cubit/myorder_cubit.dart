import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../order/domain/entities/orders.dart';

part 'myorder_state.dart';

class MyorderCubit extends Cubit<MyorderStates> {
  MyorderCubit() : super(MyorderInitial());
  static MyorderCubit get(context) => BlocProvider.of(context);
  List<OrderEntity> orders = [];
  bool noOrder = false;
  Future<List<OrderEntity>> getMyOrder() async {
    // emit(GetMyorderloading());
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(FirebaseStrings.ordersCollection)
        .orderBy("time", descending: true)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        noOrder = true;
      } else {
        orders=[];
        orders = value.docs.map((e) => OrderEntity.fromJson(e.data())).toList();
        noOrder = false;
      }
      // emit(GetMyordersuccess());
    }).catchError((err) {
      debugPrint(err.toString());
      // emit(GetMyorderError());
    });
    

     return orders; 
     
  }
}
