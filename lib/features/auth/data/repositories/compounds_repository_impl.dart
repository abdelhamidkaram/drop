import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/data/datasources/local_data/compound_local_data_source.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/compound_repository.dart';
import '../datasources/remote_data/componds_remote_data_source.dart';

class CompoundRepositoryImpl implements CompoundRepository {
  CompoundRemoteDataSource compoundRemoteDataSource ;
  CompoundsLocalDataSource compoundsLocalDataSource;
  NetworkInfo networkInfo;
  CompoundRepositoryImpl({required this.compoundsLocalDataSource , required this.compoundRemoteDataSource , required this.networkInfo});


  @override
  Future<Either<Failure, bool>> deleteCompounds(String uid) {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> editCompounds(String uid) {
    
    throw UnimplementedError();
  }


  Future<Either<Failure, List<Compound>>> _getRemoteData(String uid) async {
    if (await networkInfo.isConnected) {
      return (await compoundRemoteDataSource.getCompound(uid))
        .fold((failure) => Left(failure), (compounds) async {
    await compoundsLocalDataSource.setCompoundsToCache(compounds);
    return Right(compounds);
    });
    } else {
    return const Left(NetworkFailure(
    code: AppErrorValues.networkErrorCode,
    message: AppStrings.errorNetwork));
    }
  }

  @override
  Future<Either<Failure, List<Compound>>> getCompounds(String uid , bool isRefresh) async {
    try {
      if (!isRefresh) {
        final compounds = await compoundsLocalDataSource.getCompounds();
        debugPrint("compound local -----------------------------------------------------------");
        return Right(compounds);
      } else {
        debugPrint("compound remote ----------------------> refresh -------------------------------------");
        return await _getRemoteData(uid);
      }
    } catch (err) {
      debugPrint("compound remote ------------------------> error ----------------------------------");
      return await _getRemoteData(uid);
    }

  }
  @override
  Future<Either<Failure, bool>> addCompoundsToUser(String uid , List<Compound>chooseCompounds) async {
    if (await networkInfo.isConnected) {

      if(chooseCompounds.isNotEmpty){
        return await compoundRemoteDataSource.addCompoundsToUser(uid, chooseCompounds);
      }else{
        return const Right(false);
      }

    }else{
      return const Left(NetworkFailure(message: AppStrings.errorNetwork, code: AppErrorValues.networkErrorCode));
    }
  }

}