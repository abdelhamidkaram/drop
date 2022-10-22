import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/domain/repositories/register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_values.dart';
import '../datasources/remote_data/register_remote_data_source.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImpl(
      {required this.networkInfo, required this.registerRemoteDataSource});

  @override
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      return (await registerRemoteDataSource.registerWithEmail(email, password))
          .fold((l) {
        return left(l);
      }, (r) {
        return Right(r);
      });
    } else {
      return const Left(NetworkFailure(
          message: AppStrings.errorNetwork,
          code: AppErrorValues.networkErrorCode));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithGoogle() async {
    if (await networkInfo.isConnected) {
      return (await registerRemoteDataSource.registerWithGoogle()).fold(
              (l) => Left(l),
              (r) =>Right(r));
    } else {
      return const Left(NetworkFailure(
          code: AppErrorValues.networkErrorCode,
          message: AppStrings.errorNetwork));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithFacebook() async {
    if (await networkInfo.isConnected) {
      try {
        return ( await registerRemoteDataSource.registerWithFacebook()).fold(
                (l) => Left(l),
                (r) =>Right(r));
      } catch (error) {
        return Left(ServerFailure(
            message: error.toString(), code: AppErrorValues.serverErrorCode));
      }
    } else {
      return const Left(
          NetworkFailure(
          code: AppErrorValues.networkErrorCode,
          message: AppStrings.errorNetwork));
    }
  }


}
