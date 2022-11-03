import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';

class Order {
    Order({
        required this.car,
        required this.essentials,
        required this.promoCode,
        required this.location,
        required this.details,
        required this.id,
        required this.time,
        required this.isFinish,
        required this.price,
    });

    final Car car;
    final List<Essential> essentials;
    final PromoCode promoCode;
    final LocationEntity location;
    final String details;
    final String id;
    final String time;
    final String price;
    final bool isFinish;
    factory Order.fromJson(Map<String, dynamic> json) => Order(
        car: Car.fromJson(json["car"]),
        essentials: List<Essential>.from(json["essentials"].map((x) => Essential.fromJson(x))),
        promoCode:PromoCode.fromJson(json["promoCode"]),
        location: LocationEntity.formJson(json["location"]) ,
        details:  json["details"],
        id: json["id"],
        time: json["time"],
        isFinish: json["isFinish"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "car": car.toJson(),
        "essentials":List<dynamic>.from(essentials.map((x) => x.toJson())),
        "promoCode":  promoCode.toJson(),
        "location": location.toJson(),
        "details": details,
        "id": id ,
        "time": time ,
        "isFinish": isFinish,
        "price": price,
    };
}

class Essential {
   final String price;
    final String name;
    final String photo;
    Essential({
        required this.price,
        required this.name,
        required this.photo,
    });
    factory Essential.fromJson(Map<String, dynamic> json) => Essential(
        price: json["price"],
        name: json["name"] ,
        photo: json["photo"] ,
    );

    Map<String, dynamic> toJson() => {
        "price": price ,
        "name": name ,
        "photo": photo,
    };
}

class PromoCode {
    PromoCode({
        required this.code,
        required this.discount,
    });

    final String code;
    final String discount;

    factory PromoCode.fromJson(Map<String, dynamic> json) => PromoCode(
        code: json["code"],
        discount: json["discount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "discount": discount,
    };
}
