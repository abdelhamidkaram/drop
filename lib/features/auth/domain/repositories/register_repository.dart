import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';

abstract class RegisterRepository {
  Future<Either<Failure, User>> registerWithEmail(
      {required String email,
      required String password,
      required String name,
      required String phone});

  Future<Either<Failure, User>> registerWithGoogle();

  Future<Either<Failure, UserCredential>> registerWithFacebook();
}
