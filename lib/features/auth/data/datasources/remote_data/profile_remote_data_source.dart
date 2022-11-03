import 'package:dartz/dartz.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/auth/data/models/user_model.dart';
import '../../../../../core/api/firestore_strings.dart';
import '../../../../../core/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, UserDetailsModel>> getProfileDataSource(String uid);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<Either<Failure, UserDetailsModel>> getProfileDataSource(String uid) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.usersCollection)
          .doc(uid)
          .get();
      return Right(UserDetailsModel.formJson(response.data()!));
    } catch (err) {
      return const Left(ServerFailure(
          message: AppStrings.errorInternal,
          code: AppErrorValues.serverErrorCode));
    }
  }
}
