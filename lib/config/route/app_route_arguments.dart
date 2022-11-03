import '../../features/auth/domain/entities/location.dart';

class LocationsArgs {
  final bool formProfileScreen;
  final LocationEntity? locationEntity;

  LocationsArgs({this.locationEntity, required this.formProfileScreen});
}
class CompoundsViewArgs{
  final bool toAddCarScreen;
  CompoundsViewArgs({required this.toAddCarScreen});
}