import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/network/network_info.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/local_data/location_local_data_source.dart';
import '../datasources/remote_data/locations_remote_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final NetworkInfo networkInfo;

  final LocationRemoteDataSource locationRemoteDataSource;

  final LocationsLocalDataSource locationsLocalDataSource;

  LocationRepositoryImpl(
      {required this.locationsLocalDataSource,
      required this.networkInfo,
      required this.locationRemoteDataSource});

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations(
      String uid, bool isRefresh) async {
    try {
      late List<LocationEntity> locations;
      if (!isRefresh) {
        debugPrint("location local  ---------------------------------------------------------");
        locations = await locationsLocalDataSource.getLocations();
      } else {
        debugPrint("location remote ----------------> refresh -----------------------------------------");
        return await getRemoteData(uid, networkInfo, locationsLocalDataSource, locationRemoteDataSource);
      }
      return Right(locations);
    } catch (err) {
      debugPrint("location remote  ----------------> error cache  -----------------------------------------");
      return await getRemoteData(uid, networkInfo, locationsLocalDataSource, locationRemoteDataSource);
    }
  }
}

Future<Either<Failure, List<LocationEntity>>> getRemoteData(
    String uid,
    NetworkInfo networkInfo,
    LocationsLocalDataSource locationsLocalDataSource,
    LocationRemoteDataSource locationRemoteDataSource) async {
  if (await networkInfo.isConnected) {
    return (await locationRemoteDataSource.getLocations(uid))
        .fold((failure) => Left(failure), (locations) async {
      await locationsLocalDataSource.setLocationsToCache(locations);
      return Right(locations);
    });
  } else {
    return const Left(NetworkFailure(
        code: AppErrorValues.networkErrorCode,
        message: AppStrings.errorNetwork));
  }
}
