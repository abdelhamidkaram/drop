import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'car.dart';
import 'location.dart';

class Order extends Equatable{
  Car? car;
  Essential? essential;
  PromoCode? promoCode;
  LocationEntity? location;
  Timestamp? time ;
  bool?  isFinish = false ;
  @override
  List<Object?> get props => throw UnimplementedError();
}


class Essential extends Equatable{

  String? name ;
  String? photo ;
  String? price ;

  Essential.formJson(Map<String , dynamic > json ){
   name = json["name"] ;
   photo = json["photo"] ;
   price = json["price"] ;
  }

  Map<String , dynamic > toJson()=>{
    "name" : name ,
    "photo" : photo ,
    "price" : price ,
  };

  @override
  List<Object?> get props => [name , photo , price];

}
class PromoCode extends Equatable{
  String? code ;
  String? discount ;

  PromoCode.formJson(Map<String , dynamic > json ){
   code = json["code"] ;
   discount = json["discount"] ;
  }

  Map<String , dynamic > toJson()=>{
    "code" : code ,
    "discount" : discount ,
  };

  @override
  List<Object?> get props => [code , discount];

}