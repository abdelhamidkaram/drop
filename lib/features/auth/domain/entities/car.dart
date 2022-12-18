import 'package:equatable/equatable.dart';

class Car extends Equatable {
  String? licenseNumber;
  String? brand;
  String? color;
  String? licensePlate;
  String? model;
  String? id;

  Car({
    required this.licenseNumber,
    required this.brand,
    required this.color,
    required this.licensePlate,
    required this.model,
    required this.id,
  });

  Car.fromJson(Map<String, dynamic> json) {
    licenseNumber = json["licenseNumber"];
    brand = json["brand"];
    color = json["color"];
    licensePlate = json["licensePlate"];
    model = json["model"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    return {
      "licenseNumber": licenseNumber,
      "brand": brand,
      "color": color,
      "licensePlate": licensePlate,
      "model": model,
      "id": id,
    };
  }

  String getInfo() =>
      "${brand ?? ''} ${model ?? ''} - $licenseNumber ${licensePlate ?? ''}";

  @override
  List<Object?> get props => [licenseNumber, licensePlate, model, brand, color];
}
