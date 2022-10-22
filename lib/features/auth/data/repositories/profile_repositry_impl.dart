import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_string.dart';
import '../../domain/repositories/profile_repositry.dart';
import '../../../../core/utils/app_values.dart';
import '../datasources/remote_data/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource ;
  ProfileRepositoryImpl({required this.profileRemoteDataSource, required this.networkInfo });
  @override
  Future<Either<Failure, UserDetails>> getProfileData(String uid) async {
    if(await networkInfo.isConnected){
      return profileRemoteDataSource.getProfileDataSource(uid);
    }else{
      return const Left(NetworkFailure(
          code: AppErrorValues.networkErrorCode ,
          message: AppStrings.errorNetwork
      ));
    }

  }

}