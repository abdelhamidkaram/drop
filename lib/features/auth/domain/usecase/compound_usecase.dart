import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import '../repositories/compound_repository.dart';
import '../request_models.dart';

class GetCompoundUseCase implements UseCase<List<Compound> , CompoundsRequest>{
  CompoundRepository compoundRepository;
  GetCompoundUseCase({required this.compoundRepository});
  @override
  Future<Either<Failure, List<Compound>>> call(CompoundsRequest compoundsRequest) async {
    return await compoundRepository.getCompounds(compoundsRequest.uid, compoundsRequest.isRefresh);
  }
}

class AddCompoundToUserUseCase implements UseCase<bool , AddCompoundsToUserRequest>{
  CompoundRepository compoundRepository;
  AddCompoundToUserUseCase({required this.compoundRepository});
  @override
  Future<Either<Failure, bool >> call(AddCompoundsToUserRequest addCompoundsToUserRequest) async {
    return await compoundRepository.addCompoundsToUser(addCompoundsToUserRequest.uid, addCompoundsToUserRequest.chooseCompounds);
  }
}