import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceEntity>>> getServices();
}
