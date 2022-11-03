import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import '../../../../../core/api/firestore_strings.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/app_string.dart';
import 'package:dropeg/features/auth/data/mapper.dart';


abstract class CompoundRemoteDataSource {
  Future<Either<Failure , List<Compound>>> getCompound(String uid);
  Future<Either<Failure , bool >> addCompoundsToUser(String uid , List<Compound> chooseCompounds);
}

class CompoundRemoteDataSourceImpl  implements CompoundRemoteDataSource {
  @override
  Future<Either<Failure, List<Compound>>> getCompound(String uid) async  {
     try{
       var  response = await  FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection)
           .doc(uid)
           .collection(FirebaseStrings.compoundsCollection)
           .get();
       List<Compound> compounds = response.docs.map((e) => Compound.formJson(e.data()).toDomain()).toList();
       return Right(compounds);
     }catch(err){
       return const Left(ServerFailure(code: AppErrorValues.serverErrorCode , message: AppStrings.errorInternal));
     }
  }

  @override
  Future<Either<Failure, bool>> addCompoundsToUser(String uid, List<Compound> chooseCompounds) async {
    try {
      for(Compound compound in chooseCompounds){
         await FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection)
            .doc(uid).collection(FirebaseStrings.compoundsCollection)
            .doc(compound.name)
            .set(compound.toJson());
      }
      return const Right(true);
    }catch (err) {
      return const Left(ServerFailure(message: AppStrings.errorInternal ,  code: AppErrorValues.serverErrorCode));
    }
  }

}