import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:equatable/equatable.dart';
import 'car.dart';
import 'orders.dart';

class UserDetails extends Equatable {
   String?  name;
   String?  refreshToken;
   String?  email;
   String? phone;
   String?  id;
   bool? isVerify;
   List<Car>? cars;
   List<LocationEntity>? locations;
   List<Order>? orders;
   UserDetails(
      {
      required this.refreshToken,
      required this.isVerify,
      this.orders,
      this.locations,
      this.cars,
      required this.name,
      required this.phone,
      required this.email,
      required this.id});

  Map<String , dynamic > toJson()=>{
    "name":name,
    "phone":phone,
    "email":email,
    "id":id,
    "isEmailVerification":isVerify,
  };
  UserDetails.fromJson(Map<String , dynamic > json ){
    name = json["name"] ?? "" ;
    id = json["id"] ?? "" ;
    email = json["email"] ?? "" ;
    phone = json["phone"] ?? "" ;
    cars = json["cars"] ?? "" ;
    locations = json["locations"] ?? "" ;
    orders = json["orders"] ?? "" ;
    isVerify = json["isVerify"] ?? "" ;
    refreshToken = json["refreshToken"] ?? "" ;
  }
  @override
  List<Object?> get props => [id, phone, name, email];
}
