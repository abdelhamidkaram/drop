import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/data/mapper.dart';


abstract class CarsRemoteDataSource {
  Future<Either<Failure , List<Car>>> getCars(String uid);
}
class CarsRemoteDataSourceImpl implements CarsRemoteDataSource {
  @override
  Future<Either<Failure, List<Car>>> getCars(String uid)async{
    try{
      var response = await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection)
          .doc(uid)
          .collection(FirebaseStrings.carCollection)
          .get();
      List<Car> cars = response.docs.map((car){
        return Car.fromJson(car.data()).toDomain();
      }).toList();
      return Right(cars);
    }catch(err){
      return const Left( ServerFailure(message: AppStrings.errorInternal, code: AppErrorValues.serverErrorCode));
    }
  }

}