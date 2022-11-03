import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import '../entities/car.dart';

abstract class CarsRepository {
  Future<Either<Failure, List<Car>>> getCars(String uid , bool isRefresh);
}