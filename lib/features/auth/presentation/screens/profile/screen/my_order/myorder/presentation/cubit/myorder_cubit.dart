import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
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
      orders = value.docs.map((e) => Order(
        car: Car(a: e.data()["a"], b: e.data()["b"], c: e.data()["c"], brand: e.data()["brand"], color: e.data()["color"], licensePlate: e.data()["licensePlate"], model: e.data()["model"], id: e.data()["id"]),
         essentials: [Essential(price: "price", name: "name", photo: "photo")],
          promoCode: PromoCode(code: "code", discount: "discount"),
           location: LocationEntity(address: "address", state: "state", city: "city", type: "type", id: "id"),
            details: e.data()["details"], id: e.data()["id"], time: e.data()["time"], isFinish: e.data()["isFinish"], price: e.data()["price"])).toList();
      emit(GetMyordersuccess());
    }).catchError((err) {
      debugPrint(err.toString());
      emit(GetMyorderError());
    });
  }


}
