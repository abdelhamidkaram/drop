import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String title;
  final String details;
  final String id;
  final String img;
  final List<ServiceProvider> serviceProviders;

  const ServiceEntity({
    required this.details,
    required this.id,
    required this.img,
    required this.title,
    required this.serviceProviders,
  });

  @override
  List<Object?> get props => [id, title, img];
}

class ServiceProvider extends Equatable {
  final String title;
  final String details;
  final String id;
  final String img;
  final List<ServiceProvideList>? serverProvideList;

  const ServiceProvider(
      {required this.title,
      required this.details,
      required this.id,
      required this.img,
      required this.serverProvideList
      
      });

  Map<String, dynamic> toJson() =>
      {"title": title,
       "details": details,
        "id": id,
        "img": img ,
         "serverProvideList": serverProvideList?.map((e) => e.toJson()).toList()};
  @override
  List<Object?> get props => [id, title, details];
}

class ServiceProvideList extends Equatable {
  final String serviceName;
  final String price;
  final String img;
  final String id;
  const ServiceProvideList({
    required this.serviceName,
    required this.price,
    required this.img,
    required this.id,
  });
  Map<String, dynamic> toJson() =>
      {"serviceName": serviceName, "price": price, "id": id, "img": img};
  @override
  List<Object?> get props => [serviceName, price, img, id];
}
