import 'package:dartz/dartz.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/api/firestore_strings.dart';
import '../../../../../core/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
abstract class ProfileRemoteDataSource{
  Future<Either<Failure , UserDetails>> getProfileDataSource(String uid);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  @override
  Future<Either<Failure, UserDetails>> getProfileDataSource(String uid) async {

 try{
   await FirebaseFirestore.instance.
   collection(FirebaseStrings.usersCollection).
   doc(uid).
   get().
   then((value){
     if(value.exists){
       return Right(UserDetails.fromJson(value.data()!));
     }
   });
 }catch(err){
   debugPrint(err.toString());
 }
return const Left(ServerFailure(message: AppStrings.errorInternal , code: AppErrorValues.serverErrorCode));
  }

}