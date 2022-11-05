import 'package:dropeg/features/home/data/mapper.dart';
import 'package:dropeg/features/home/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  final List<ServiceProviderModel> serviceModelProviders ; 
   ServiceModel({
    required details,
    required id,
    required img,
    required title,
    required this.serviceModelProviders, 
  
  }) : super(details: details , id: id, img: img , title: title, 
   serviceProviders: serviceModelProviders.map((e) => e.toDomain()).toList());

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        details: json["details"],
        id: json["id"],
        img: json["img"],
        title: json["title"],
        serviceModelProviders: json["serviceProviders"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "id": id,
        "img": img,
        "title": title,
        "serviceProviders": serviceModelProviders.map((e) => e.toJson()).toList(),
      };
}

class ServiceProviderModel extends ServiceProvider {
  const ServiceProviderModel(
      {required super.title,
      required super.details,
      required super.id,
      required super.img});

  factory ServiceProviderModel.formJson(Map<String, dynamic> json) =>
      ServiceProviderModel(
        title: json["title"],
        details: json["details"],
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() =>
      {"title": title, "details": details, "id": id, "img": img};
      
}
