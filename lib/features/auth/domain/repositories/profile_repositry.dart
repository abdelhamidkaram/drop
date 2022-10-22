import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure , UserDetails >> getProfileData(String uid);
}