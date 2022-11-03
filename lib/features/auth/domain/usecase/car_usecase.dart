import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import '../entities/car.dart';
import '../repositories/car_repository.dart';
import '../request_models.dart';

class CarsUseCase extends UseCase<List<Car> , CarsRequest>{
  final CarsRepository carsRepository;
  CarsUseCase({required this.carsRepository});
  @override
  Future<Either<Failure, List<Car>>> call(CarsRequest params ) async {
    return await carsRepository.getCars(params.uid  , params.isRefresh);
  }
}