import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/order/domain/entities/required_service.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.car,
    required this.essentials,
    required this.promoCode,
    required this.location,
    required this.details,
    required this.id,
    required this.uid,
    required this.time,
    required this.isFinish,
    required this.price,
    required this.requiredServices,
    required this.status,
    required this.vat,
    required this.grandTotal,
  });

  final Car car;
  final int status;
  final List<Essential> essentials;
  final List<RequiredService> requiredServices;
  final PromoCode promoCode;
  final LocationEntity location;
  final String details;
  final String id;
  final String uid;
  final String time;
  final double vat;
  final double grandTotal;
  final String price;
  final bool isFinish;
  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    List essentialsList = json["essentials"];
    List requiredServicesList = json["requiredServices"];
    return OrderEntity(
        status: json["status"],
        requiredServices: List<RequiredService>.from(
            requiredServicesList.map((e) => RequiredService.fromJson(e))),
        car: Car.fromJson(json["car"]),
        essentials: List<Essential>.from(
            essentialsList.map((e) => Essential.fromJson(e))),
        promoCode: PromoCode.fromJson(json["promoCode"]),
        location: LocationEntity.formJson(json["location"]),
        details: json["details"],
        id: json["id"],
        time: json["time"],
        isFinish: json["isFinish"],
        price: json["price"],
        uid: json["uid"],
        vat: json["vat"],
        grandTotal: json['grandTotal']);
  }

  Map<String, dynamic> toJson() => {
        "car": car.toJson(),
        "essentials": List<dynamic>.from(essentials.map((x) => x.toJson())),
        "requiredServices":
            List<dynamic>.from(requiredServices.map((x) => x.toJson())),
        "promoCode": promoCode.toJson(),
        "location": location.toJson(),
        "details": details,
        "id": id,
        "time": time,
        "isFinish": isFinish,
        "price": price,
        "uid": uid,
        "status": status,
        "vat": vat,
        "grandTotal": grandTotal,
      };

  String getInfo() =>
      "${requiredServices.map((e) => e.name).toList().toString().substring(1, requiredServices.map((e) => e.name).toList().toString().length - 1)} - ${car.brand} ${car.model} -${location.address}";

  @override
  List<Object?> get props => [id, uid];
}

class Essential {
  final String price;
  final String name;
  final String photo;
  final String id;
  Essential(
      {required this.price,
      required this.name,
      required this.photo,
      required this.id});
  factory Essential.fromJson(Map<String, dynamic> json) => Essential(
        price: json["price"],
        name: json["name"],
        photo: json["photo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() =>
      {"price": price, "name": name, "photo": photo, "id": id};
}

class PromoCode {
  PromoCode({
    required this.code,
    required this.discount,
    required this.type,
  });

  final String code;
  final String discount;
  final PromoCodeType type;

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    convertStringToType() {
      switch (json["type"].toString()) {
        case "PromoCodeType.referral":
          return PromoCodeType.referral;
        case "PromoCodeType.test":
          return PromoCodeType.test;
        case "PromoCodeType.voucher":
          return PromoCodeType.voucher;
        default:
          return PromoCodeType.test;
      }
    }

    return PromoCode(
      code: json["code"],
      discount: json["discount"],
      type: convertStringToType(),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "discount": discount,
        "type": type.toString(),
      };
}
