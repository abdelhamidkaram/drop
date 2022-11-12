import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:dropeg/features/home/features/services/data/models/service_model.dart';
import 'package:flutter/foundation.dart';

abstract class ServicesRemoteDataSource {
  Future<Either<Failure, List<ServiceModel>>> getServices();
}

class ServicesRemoteDataSourceImpl extends ServicesRemoteDataSource {
  @override
  Future<Either<Failure, List<ServiceModel>>> getServices() async {
    try {
      List<ServiceModel> services;
      var response = await FirebaseFirestore.instance
          .collection(FirebaseStrings.servicesCollection)
          .get();
      services =
          response.docs.map((e) => ServiceModel.fromJson(e.data())).toList();
      return Right(services);
    } catch (e) {
      debugPrint(e.toString());

      return const Left(ServerFailure(
          code: AppErrorValues.serverErrorCode,
          message: AppStrings.errorInternal));
    }
  }
}
