import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';
import '../request_models.dart';

class LocationUseCase extends UseCase<List<LocationEntity>, LocationsRequest>{
 final  LocationRepository locationRepository;
 LocationUseCase({required this.locationRepository});
  @override
  Future<Either<Failure, List<LocationEntity>>> call(LocationsRequest params) async  {
    return await locationRepository.getLocations(params.uid, params.isRefresh);
  }


}