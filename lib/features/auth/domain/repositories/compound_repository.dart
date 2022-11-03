import 'package:dartz/dartz.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';

import '../../../../core/error/failure.dart';

abstract class CompoundRepository {

  Future<Either<Failure, List<Compound>>> getCompounds(String uid , bool isRefresh);
  Future<Either<Failure, bool>> addCompoundsToUser(String uid , List<Compound> chooseCompounds );
  Future<Either<Failure, bool>> deleteCompounds(String uid);
  Future<Either<Failure, bool>> editCompounds(String uid);

}