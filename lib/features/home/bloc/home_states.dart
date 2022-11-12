import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {}

class HomeStateInit extends HomeStates {
  @override
  List<Object?> get props => [];
}

class GetMainLocationSuccess extends HomeStates {
  @override
  List<Object?> get props => [];
}
class GetMainLocationError extends HomeStates {
  @override
  List<Object?> get props => [];
}
class GetMainLocationloading extends HomeStates {
  @override
  List<Object?> get props => [];
}


class GetServicesSuccess extends HomeStates {
  final List<ServiceEntity> services;
  GetServicesSuccess({required this.services});
  @override
  List<Object?> get props => [services];
}
class GetServicesError extends HomeStates {
  final String msg;
  GetServicesError({required this.msg});
  @override
  List<Object?> get props => [msg];
}
class GetServicesloading extends HomeStates {
  @override
  List<Object?> get props => [];
}


