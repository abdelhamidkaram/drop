import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/features/auth/domain/repositories/register_repository.dart';
import 'package:dropeg/features/auth/domain/request_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/usecase/usecase.dart';

class GetRegisterWithEmail implements UseCase<User, RegisterRequest> {
  final RegisterRepository registerRepository;

  GetRegisterWithEmail({required this.registerRepository});

  @override
  Future<Either<Failure, User>> call(RegisterRequest params) async {
    return await registerRepository.registerWithEmail(
      password: params.password,
      email: params.email,
      name: params.name,
      phone: params.phone,
    );
  }
}

class GetRegisterWithFaceBook implements UseCase<UserCredential, String> {
  final RegisterRepository registerRepository;
  GetRegisterWithFaceBook(this.registerRepository);

  @override
  Future<Either<Failure, UserCredential>> call(s) async {
    return await registerRepository.registerWithFacebook();
  }
}

class GetRegisterWithGoogle implements UseCase<User, String> {
  final RegisterRepository registerRepository;

  GetRegisterWithGoogle(this.registerRepository);

  @override
  Future<Either<Failure, User>> call(s) async {
    return await registerRepository.registerWithGoogle();
  }
}
