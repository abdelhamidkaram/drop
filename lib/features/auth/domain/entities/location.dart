import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  String? address;

  String? state;

  String? city;

  String? type;

  LocationEntity(
      {required this.address,
      required this.state,
      required this.city,
      required this.type});
  LocationEntity.formJson(Map<String , dynamic> json){
    address = json["address"];
    state = json["state"];
    city = json["city"];
    type = json["type"];

  }

  Map<String , dynamic > toJson()=>{
    "address":address,
    "state":state,
    "city":city,
    "type":type,
  };


  @override
  // TODO: implement props
  List<Object?> get props =>[address , state , city];
}
