import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/data/mapper.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_string.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repositry.dart';
import '../../../../core/utils/app_values.dart';
import '../datasources/local_data/profile_local_data_source.dart';
import '../datasources/remote_data/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileLocalDataSource profileLocalDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(
      {
      required this.profileLocalDataSource,
      required this.profileRemoteDataSource,
      required this.networkInfo ,
      });

  @override
  Future<Either<Failure, UserDetails>> getProfileData(
      String uid, bool isRefresh) async {
    try { ///TODO:
      if (false) { 
       
        final userDetailsModel = await profileLocalDataSource.getProfileDetails();
        debugPrint("profile details  local  ---------------------------------------------------------");
        return Right(userDetailsModel.toDomain());
      } else {
        debugPrint("profile details  remote   -------------------> refresh ----------------------------");
        return getRemoteData(networkInfo, profileLocalDataSource, profileRemoteDataSource, uid);
      }
    } catch (err) {
      debugPrint("profile details  remote   -------------------> error cache ----------------------------");
      return getRemoteData(networkInfo, profileLocalDataSource, profileRemoteDataSource, uid);
    }
  }
}

Future<Either<Failure, UserDetails>> getRemoteData(NetworkInfo networkInfo , ProfileLocalDataSource profileLocalDataSource , ProfileRemoteDataSource profileRemoteDataSource , String uid)async {
  if (await networkInfo.isConnected) {
    return (await profileRemoteDataSource.getProfileDataSource(uid))
        .fold((failure) => Left(failure), (user) async {
      await profileLocalDataSource.setProfileDetailsToCache(user);
      return Right(user.toDomain());
    });
  } else {
    return const Left(NetworkFailure(
        code: AppErrorValues.networkErrorCode,
        message: AppStrings.errorNetwork));
  }
}