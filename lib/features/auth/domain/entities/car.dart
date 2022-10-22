import 'package:equatable/equatable.dart';

class Car extends Equatable {
   String?  a;
   String?  b;
   String?  c;
   String?  brand;
   String? color;
   String?  licensePlate;
   String?  model;

    Car({
      required this.a,
      required this.b,
      required this.c,
      required this.brand,
      required this.color,
      required this.licensePlate,
      required this.model
    });

  Car.fromJson(Map<String , dynamic > json){
   a =json["A"] ;
   b =json["B"] ;
   c =json["C"] ;
   brand =json["brand"] ;
   color =json["color"] ;
   licensePlate =json["licensePlate"] ;
   model =json["model"] ;
  }

  Map<String , dynamic > toJson (){
    return {
      "A":a,
      "B" : b,
      "C" : c,
      "brand" : brand,
      "color" : color,
      "licensePlate" : licensePlate,
      "model" : model,
    };
  }

  @override
  List<Object?> get props => [a ,b , c, licensePlate , model ,brand , color ];
}
