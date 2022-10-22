import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data/login_remote_data_source.dart';

class LoginRepositoryImp implements LoginRepository{
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource   loginRemoteDataSource;

  LoginRepositoryImp({required this.loginRemoteDataSource, required this.networkInfo});


  @override
  Future<Either<Failure, User?>> loginWithEmail({required String email, required String password}) async {
    if(await networkInfo.isConnected){
      try{
        return await loginRemoteDataSource.loginWithEmail(email, password);
      }catch(error){
        debugPrint(error.toString());
        return  Left(ServerFailure(message: error.toString().split(']').last, code: AppErrorValues.serverErrorCode));
      }
    }else {
      return  const Left(NetworkFailure(message:AppStrings.errorNetwork , code: AppErrorValues.networkErrorCode ));
    }
}

  @override
  Future<Either<Failure, bool>> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      return const Right(true);
    }).catchError(
            (err){
          if (kDebugMode) {
            print(err.toString());
          }
        }
    );
    return const Left(ServerFailure(code: -2 , message: AppStrings.errorInternal));
  }






}
