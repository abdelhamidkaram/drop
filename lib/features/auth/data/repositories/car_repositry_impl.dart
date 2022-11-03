import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/data/datasources/local_data/car_local_data_source.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/car_repository.dart';
import '../datasources/remote_data/cars_remote_data_source.dart';

class CarsRepositoryImpl implements CarsRepository{
  final CarsRemoteDataSource carsRemoteDataSource;
  final CarsLocalDataSource carsLocalDataSource;
  final NetworkInfo networkInfo;
  CarsRepositoryImpl({required this.carsLocalDataSource ,required this.carsRemoteDataSource ,required this.networkInfo,  });
  @override
  Future<Either<Failure, List<Car>>> getCars(String uid , bool isRefresh) async {
    try {
      if (!isRefresh) {
        final cars = await carsLocalDataSource.getCars();
        debugPrint("cars local ----------------------------------");
        return Right(cars);
      } else {
        debugPrint("compound remote -------> refresh  -----------");
        return await _remoteData(uid);
      }
    } catch (err) {
      debugPrint("compound remote --------> error --------------");
      return await _remoteData(uid);
    }


  }

  Future<FutureOr<Either<Failure, List<Car>>>> _remoteData(String uid) async {
    if (await networkInfo.isConnected) {
      return (await carsRemoteDataSource.getCars(uid))
          .fold((failure) => Left(failure), (cars) async {
        await carsLocalDataSource.setCarsToCache(cars);
        return Right(cars);
      });
    } else {
      return const Left(NetworkFailure(
          code: AppErrorValues.networkErrorCode,
          message: AppStrings.errorNetwork));
    }
  }
  
}