import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';

import '../../features/auth/domain/entities/location.dart';

class LocationsArgs {
  final bool formProfileScreen;
  final LocationEntity? locationEntity;

  LocationsArgs({this.locationEntity, required this.formProfileScreen});
}

class CompoundsViewArgs {
  final bool toAddCarScreen;
  CompoundsViewArgs({required this.toAddCarScreen});
}

class SingleProviderArgs {
  final ServiceEntity serviceEntity;
  SingleProviderArgs(this.serviceEntity);
}

class SingleProviderServicesArgs {
  final ServiceEntity serviceEntity;
  final int index;
  SingleProviderServicesArgs(
      {required this.serviceEntity, required this.index});
}

class ScheduleAppointmentArgs {
  final ServiceEntity serviceEntity;
  final int index;
  final ServiceProvideList? serviceProvideList;
  ScheduleAppointmentArgs(
      {required this.serviceEntity, required this.index, required this.serviceProvideList});
}
class SingleProviderOrderConfirmedArgs {
  final ServiceProvideList? serviceProvideList;
  SingleProviderOrderConfirmedArgs(
      {required this.serviceProvideList});
}



///////////////////
class OrderMainArgs {
  final LocationEntity locationEntity ;
  OrderMainArgs({required this.locationEntity});
}
