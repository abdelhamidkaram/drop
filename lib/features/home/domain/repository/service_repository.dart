import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/home/domain/entity/service_entity.dart';

abstract class ServiceRepository {
  Future<Either<Failure, ServiceEntity>> getServices();
}
