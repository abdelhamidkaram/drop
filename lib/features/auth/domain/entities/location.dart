import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  String? address;
  String? state;
  String? city;
  String? type;
  String? id;

  LocationEntity(
      {required this.address,
      required this.state,
      required this.city,
      required this.type,
      required this.id});

  LocationEntity.formJson(Map<String, dynamic> json) {
    address = json["address"];
    state = json["state"];
    city = json["city"];
    type = json["type"];
    id = json["id"];
  }

  String get addressForView {
    return (this.city ?? "") + '-' + (this.state ?? "");
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "state": state,
        "city": city,
        "type": type,
        "id": id,
      };

  @override
  List<Object?> get props => [address, state, city, id];
}
