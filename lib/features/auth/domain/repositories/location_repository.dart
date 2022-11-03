import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getLocations(String uid , bool isRefresh);
}