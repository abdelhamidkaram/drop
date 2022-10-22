import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import '../repositories/profile_repositry.dart';

class GetProfileUseCase implements UseCase< UserDetails , String>{
  ProfileRepository profileRepository ;
  GetProfileUseCase({required this.profileRepository});
  @override
  Future<Either<Failure, UserDetails>> call(String uid) {
     return  profileRepository.getProfileData(uid);
  }
}