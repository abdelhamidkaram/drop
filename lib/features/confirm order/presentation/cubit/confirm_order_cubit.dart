import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../order/domain/entities/orders.dart';

part 'confirm_order_state.dart';

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit() : super(ConfirmOrderInitial());

  static ConfirmOrderCubit get(context) => BlocProvider.of(context);

  OrderStatus orderStatus = OrderStatus.onTheWay;

  void listenToChangedOrderStatus({required OrderEntity order}) {
    emit(ChangeOrderStatusLoading());
    FirebaseFirestore.instance
        .collection(FirebaseStrings.ordersCollection)
        .doc(order.id)
        .snapshots()
        .listen((event) {
      if (event.data()?["status"] == 1) {
        emit(ChangeOrderStatusLoading());
        orderStatus = OrderStatus.onTheWay;
        _changeOrderStatusInUserCollections(
                isFinish: false, order: order, status: 1)
            .then((value) => null);
      } else if (event.data()?["status"] == 2) {
        emit(ChangeOrderStatusLoading());
        orderStatus = OrderStatus.onProgress;
        _changeOrderStatusInUserCollections(
                isFinish: false, order: order, status: 2)
            .then((value) => null);
        emit(ChangeOrderStatusSuccess());
      } else if (event.data()?["status"] == 3) {
        emit(ChangeOrderStatusLoading());
        orderStatus = OrderStatus.done;
        _changeOrderStatusInUserCollections(
                isFinish: true, order: order, status: 3)
            .then((value) => null);
      } else if (event.data()?["status"] == 4) {
        emit(ChangeOrderStatusLoading());
        orderStatus = OrderStatus.cancel;
        _changeOrderStatusInUserCollections(
                isFinish: false, order: order, status: 4)
            .then((value) =>null );
      }
    });
  
  }

  Future _changeOrderStatusInUserCollections(
      {required OrderEntity order,
      required bool isFinish,
      required int status}) async {
    if (isFinish == order.isFinish && status == order.status) {
      return;
    } else {
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseStrings.usersCollection)
            .doc(uId)
            .collection(FirebaseStrings.ordersCollection)
            .doc(order.id)
            .update({"status": status, "isFinish": isFinish});
                  emit(ChangeOrderStatusSuccess());

      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future cancelOrder({required OrderEntity order}) async  {
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.ordersCollection)
        .doc(order.id)
        .update({"status": 4}).then((value) {
      FirebaseFirestore.instance
          .collection(FirebaseStrings.usersCollection)
          .doc(uId)
          .collection(FirebaseStrings.ordersCollection)
          .doc(order.id)
          .update({FirebaseStrings.orderStatusField: 4}).then((value) {
      });
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  String title() {
    switch (orderStatus) {
      case OrderStatus.onProgress:
        return AppStrings.orderProgress;
      case OrderStatus.done:
        return AppStrings.orderDone;
      case OrderStatus.cancel:
        return AppStrings.orderCancel;
      default:
        return AppStrings.orderOnTheWay;
    }
  }

  String jsonAsset() {
    switch (orderStatus) {
      case OrderStatus.onProgress:
        return JsonManger.washProgress;
      case OrderStatus.done:
        return JsonManger.washDone;
      case OrderStatus.cancel:
        return JsonManger.washOnTheWay;
      default:
        return JsonManger.washOnTheWay;
    }
  }
}
