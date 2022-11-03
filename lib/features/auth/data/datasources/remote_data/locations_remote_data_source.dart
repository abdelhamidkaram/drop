import 'package:dartz/dartz.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import '../../../../../core/api/firestore_strings.dart';
import '../../../../../core/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/features/auth/data/mapper.dart';
abstract class LocationRemoteDataSource {
  Future<Either<Failure , List<LocationEntity>>> getLocations(String uid);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource{
  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations(String uid) async  {
  try{
    var response = await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection)
        .doc(uid)
        .collection(FirebaseStrings.locationsCollection)
        .get();
    List<LocationEntity> locations = response.docs.map((location){
         return LocationEntity.formJson(location.data()).toDomain();
    }).toList();
    return Right(locations);
  }catch(err){
    return const Left(ServerFailure(code: AppErrorValues.serverErrorCode , message:  AppStrings.errorInternal));
  }
  }

}