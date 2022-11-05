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

  const ServiceProvider(
      {required this.title,
      required this.details,
      required this.id,
      required this.img});

  @override
  List<Object?> get props => [id, title, details];
}
