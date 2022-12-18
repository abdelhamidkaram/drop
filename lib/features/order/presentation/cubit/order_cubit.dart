import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/Order/domain/entities/orders.dart';
import 'package:dropeg/features/Order/domain/entities/required_service.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/domain/entities/referral.dart';
import 'package:dropeg/features/auth/domain/entities/vouchers.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropeg/core/utils/constant.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of(context);
  var promoCodeController = TextEditingController();
  var fireStore = FirebaseFirestore.instance;

  String? orderDateTime = DateTime.now().toString();
  OrderTimeType orderTimeType = OrderTimeType.rightNow;
  changeOrderDateTime(
      {required DateTime dateTime, required OrderTimeType orderTimeType}) {
    emit(ChangeOrderTimeLoading());
    orderDateTime = dateTime.toString();
    this.orderTimeType = orderTimeType;
    emit(ChangeOrderTimeSuccess());
  }

  PaymentMethodType? paymentMethodType = PaymentMethodType.cash;
  changePaymentMethod({required PaymentMethodType paymentMethodType}) {
    emit(ChangePaymentTypeLoading());
    this.paymentMethodType = paymentMethodType;
    emit(ChangePaymentTypeSuccess());
  }

  LocationEntity? orderLocation;

  getOrderLocation({required LocationEntity? location}) {
    emit(GetOrderLocationLoading());
    orderLocation = location;
    emit(GetOrderLocationSuccess());
  }

  Car? carSelected;
  changedCarSelected({Car? car}) {
    emit(ChangeCarSelectedLoading());
    carSelected = car;
    emit(ChangeCarSelectedSuccess());
  }

  List<RequiredService> exteriorServices = [];
  List<RequiredService> interiorServices = [];

  getRequiredServices() async {
    if (exteriorServices.isEmpty || interiorServices.isEmpty) {
      emit(GetRequiredServicesLoading());
      await fireStore
          .collection(FirebaseStrings.requiredServicesCollection)
          .get()
          .then((value) {
        for (var e in value.docs) {
          if (e.data()["type"] == "Interior") {
            interiorServices.add(RequiredService.fromJson(e.data()));
          } else {
            exteriorServices.add(RequiredService.fromJson(e.data()));
          }
        }
        emit(GetRequiredServicesSuccess());
      }).catchError((e) {
        debugPrint(e.toString());
        emit(GetRequiredServicesError());
      });
    }
  }

  List<RequiredService> requiredSelected = [];

  getAddItemToRequiredSelected(RequiredService requiredService) {
    if (!requiredSelected.contains(requiredService) ||
        requiredSelected.isEmpty) {
      emit(AddInteriorSelectedLoading());
      requiredSelected.add(requiredService);
      total += double.tryParse(requiredService.price) ?? 0.0;

      if (requiredService.type == 'Exterior') {
        if (!_isStanderExteriorSelected()) {
          for (var e in exteriorServices) {
            if (e.name == 'Standard Exterior') {
              requiredSelected.add(e);
              total += double.tryParse(e.price) ?? 0.0;
            }
          }
        }
      } else {
        if (!_isStanderInteriorSelected()) {
          for (var e in interiorServices) {
            if (e.name == 'Standard Interior') {
              requiredSelected.add(e);
              total += double.tryParse(e.price) ?? 0.0;
            }
          }
        }
      }
      emit(AddInteriorSelectedSuccess());
    } else {
      List<RequiredService> exteriorSelectedList = [];
      for (var e in requiredSelected) {
        if (e.type == "Exterior") {
          exteriorSelectedList.add(e);
        }
      }
      var interiorSelectedList = [];
      for (var e in requiredSelected) {
        if (e.type == "Interior") {
          interiorSelectedList.add(e);
        }
      }
      emit(RemoveInteriorSelectedLoading());
      if (requiredService.type == "Interior" &&
          requiredService.name == "Standard Interior" &&
          interiorSelectedList.length != 1) {
        return;
      } else if (requiredService.type == "Exterior" &&
          requiredService.name == "Standard Exterior" &&
          exteriorSelectedList.length != 1) {
        return;
      }
      requiredSelected.remove(requiredService);
      total -= double.tryParse(requiredService.price) ?? 0.0;
      emit(RemoveInteriorSelectedSuccess());
    }
  }

  bool _isStanderExteriorSelected() {
    bool exists = false;
    for (var e in requiredSelected) {
      if (e.name == 'Standard Exterior') {
        exists = true;
      }
    }
    return exists;
  }

  bool _isStanderInteriorSelected() {
    bool exists = false;
    for (var e in requiredSelected) {
      if (e.name == 'Standard Interior') {
        exists = true;
      }
    }
    return exists;
  }

  double total = 0;
  addServices(String price) {
    emit(AddServicesLoading());
    try {
      double convertPrice = double.tryParse(price) ?? 0.0;
      if (convertPrice == 0.0) {
        debugPrint("error when convert price");
      } else {
        total += convertPrice;
      }
      emit(AddServicesSuccess());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(AddServicesError());
    }
  }

  removeServices(String price) {
    emit(RemoveServicesLoading());
    try {
      double convertPrice = double.tryParse(price) ?? 0.0;
      if (convertPrice == 0.0) {
        debugPrint("error when convert price  ");
      } else {
        total -= convertPrice;
      }
      emit(RemoveServicesSuccess());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(RemoveServicesError());
    }
  }

  int promoCodeDiscount = 0;
  PromoCodeType promoCodeType = PromoCodeType.test;
  Referral? referral;
  Voucher? voucher;
  Future<bool> getPromoCode(String? promoCode) async {
    emit(GetPromoCodeLoading());
    bool exists = false;
    try {
      await fireStore
          .collection(FirebaseStrings.vouchers)
          .doc(promoCode)
          .get()
          .then((value) async {
        exists = value.exists;

        if (!value.exists) {
          await fireStore
              .collection(FirebaseStrings.referralCodes)
              .doc(promoCode)
              .get()
              .then((value) {
            if (value.data() != null) {
              referral = Referral.formJson(value.data()!);
              exists = value.exists;
              if (value.exists) {
                promoCodeDiscount = AppConstants.referralDiscount;
                promoCodeType = PromoCodeType.referral;
              }
            }
          });
        } else {
          voucher = Voucher.formJson(value.data()!);
          promoCodeDiscount =
              int.tryParse(voucher!.discount?.split("%").first ?? "0.0") ?? 0;
          promoCodeType = PromoCodeType.voucher;
        }
      });
      if (exists) {
        emit(GetPromoCodeSuccess());
      } else {
        emit(GetPromoCodeError());
        AppToasts.errorToast(AppStrings.notValid);
      }
      return exists;
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(GetPromoCodeError());
      return false;
    }
  }

  List<Essential> essentials = [];

  getEssential() async {
    emit(GetEssentialLoading());
    await fireStore
        .collection(FirebaseStrings.essentialCollection)
        .get()
        .then((value) {
      essentials = value.docs
          .map(
            (e) => Essential.fromJson(e.data()),
          )
          .toList();
      emit(GetEssentialSuccess());
    }).catchError((err) {
      debugPrint(err.toString());
      emit(GetEssentialError());
    });
  }

  List<Essential> essentialsSelected = [];

  addOrRemoveEssentialSelected({required Essential essential}) {
    if (essentialsSelected.isNotEmpty &&
        essentialsSelected.contains(essential)) {
      emit(AddEssentialToSelectedLoading());
      essentialsSelected.remove(essential);
      total -= double.tryParse(essential.price) ?? 0.0;
      emit(AddEssentialToSelectedSuccess());
    } else {
      emit(RemoveEssentialToSelectedLoading());
      essentialsSelected.add(essential);
      total += double.tryParse(essential.price) ?? 0.0;
      emit(RemoveEssentialToSelectedSuccess());
    }
  }

  Future sendOrderToServer({required OrderEntity order}) async {
    emit(SetOrderToServerLoading());
    AppToasts.loadingToast();
    try {
      await fireStore
          .collection(FirebaseStrings.usersCollection)
          .doc(userInfo!.id)
          .collection(FirebaseStrings.ordersCollection)
          .doc(order.id)
          .set(order.toJson())
          .then((value) async {
        await fireStore
            .collection(FirebaseStrings.ordersCollection)
            .doc(order.id)
            .set(order.toJson())
            .then((value) => AppToasts.successToast(AppStrings.success));
        await updateNumberOfUse();
      });
    } on Exception catch (error) {
      debugPrint(error.toString());
      AppToasts.errorToast(AppStrings.errorInternal);
    }
  }

  Future updateNumberOfUse() async {
    try {
      if (promoCodeType == PromoCodeType.test) {
        return;
      } else if (promoCodeType == PromoCodeType.voucher) {
        if (voucher != null) {
          await fireStore
              .collection(FirebaseStrings.vouchers)
              .doc(promoCodeController.text)
              .update({
            FirebaseStrings.numberOfUsedFieldVoucher:
                voucher!.numberOfUsed! + 1,
          });
        }
      } else {
        if (referral != null) {
          await fireStore
              .collection(FirebaseStrings.referralCodes)
              .doc(promoCodeController.text)
              .update({
            FirebaseStrings.numberOfUsedFieldReferral:
                referral!.numberOfUsed! + 1,
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
