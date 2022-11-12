import 'package:dropeg/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import '../repository/service_repository.dart';

class ServiceUseCase implements UseCase<List<ServiceEntity>, NoPrams> {
  final ServicesRepository serviceRepository;

  ServiceUseCase({required this.serviceRepository});
  @override
  Future<Either<Failure, List<ServiceEntity>>> call(_) async =>
      await serviceRepository.getServices();
}
