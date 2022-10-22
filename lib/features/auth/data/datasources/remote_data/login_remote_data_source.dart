import 'package:dartz/dartz.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropeg/core/utils/app_values.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, User>> loginWithEmail(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  AppPreferences appPreferences;

  LoginRemoteDataSourceImpl(this.appPreferences);

  @override
  Future<Either<Failure, User>> loginWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      uId = userCredential.user?.uid ?? "";
      await appPreferences.loginAllCache(token, uId);
      return Right(userCredential.user!);
    } catch (err) {
      debugPrint(err.toString());
      return Left(
        ServerFailure(
            message: err.toString().split("]").last,
            code: AppErrorValues.serverErrorCode),
      );
    }
  }
}
