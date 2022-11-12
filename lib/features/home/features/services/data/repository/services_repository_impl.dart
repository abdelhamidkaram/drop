import 'package:dropeg/core/network/network_info.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dropeg/features/home/features/services/data/data_source/local_data/services_local_datasource.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:flutter/material.dart';
import '../../domain/repository/service_repository.dart';
import '../data_source/remote_data/services_remote_datasource.dart';
import '../mapper.dart';
import '../models/service_model.dart';

class ServicesRepositoryImpl extends ServicesRepository {
  final ServicesRemoteDataSource remoteDataSource;
  final ServicesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppPreferences appPreferences;
  ServicesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.appPreferences,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    try {
      if (!await appPreferences.isServicesCachedExpired()) {
        List<ServiceModel> services = await localDataSource.getServices();
        debugPrint("services local ------------------------------");
        return Right(services.map((e) => e.toDomain()).toList());
      } else {
        debugPrint("services remote -------> refresh  -----------");
        return await _remoteData();
      }
    } catch (err) {
      debugPrint("services remote --------> error --------------");
      return await _remoteData();
    }
  }

  Future<Either<Failure, List<ServiceEntity>>> _remoteData() async {
    if (await networkInfo.isConnected) {
      return (await remoteDataSource.getServices())
          .fold((failure) => Left(failure), (services) async {
        await localDataSource.setServicesToCache(services);
        return Right(services.map((e) => e.toDomain()).toList());
      });
    } else {
      return const Left(NetworkFailure(
          code: AppErrorValues.networkErrorCode,
          message: AppStrings.errorNetwork));
    }
  }
}
