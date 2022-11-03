import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import '../repositories/profile_repositry.dart';
import '../request_models.dart';

class GetProfileUseCase implements UseCase< UserDetails , ProfileDetailsRequest>{
  ProfileRepository profileRepository ;
  GetProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, UserDetails>> call(params) async {
    return (await profileRepository.getProfileData(params.uid, params.isRefresh)).fold(
    (l){
    return Left(l);
    },
    (r){
    return right(r) ;
    });
  }

}