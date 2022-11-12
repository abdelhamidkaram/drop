import 'package:dropeg/features/home/features/services/data/mapper.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required String details,
    required String id,
    required String img,
    required String title,
    required List<ServiceProvider> serviceProviders,
  }) : super(
          details: details,
          id: id,
          img: img,
          title: title,
          serviceProviders: serviceProviders,
        );

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    List providers = json["serviceProviders"];
    return ServiceModel(
      details: json["details"],
      id: json["id"],
      img: json["img"],
      title: json["title"],
      serviceProviders: providers
          .map((e) => ServiceProviderModel.formJson(e).toDomain())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "details": details,
        "id": id,
        "img": img,
        "title": title,
        "serviceProviders": serviceProviders.map((e) => e.toJson()).toList(),
      };
}

class ServiceProviderModel extends ServiceProvider {
  const ServiceProviderModel({
    final String? title,
    final String? details,
    final List<ServiceProvideList>? serverProvideList,
    final String? id,
    final String? img,
  }) : super(
          details: details ?? "",
          id: id ?? "",
          img: img ?? "",
          serverProvideList: serverProvideList,
          title: title ?? "",
        );

  factory ServiceProviderModel.formJson(Map<String, dynamic> json) {
    List? servisesList = json["serverProvideList"];
    return ServiceProviderModel(
      title: json["title"],
      details: json["details"],
      id: json["id"],
      img: json["img"],
      serverProvideList: servisesList?.map((e) => ServiceProvideListModel.formJson(e).toDomain()).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson();
}

class ServiceProvideListModel extends ServiceProvideList {
  const ServiceProvideListModel({
    required super.serviceName,
    required super.price,
    required super.img,
    required super.id,
  });

  factory ServiceProvideListModel.formJson(Map<String, dynamic> json) =>
      ServiceProvideListModel(
        id: json["id"],
        serviceName: json["serviceName"],
        img: json["img"],
        price: json["price"],
      );
  @override
  Map<String, dynamic> toJson();
}
