import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/usecase/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/login_repository.dart';
import '../request_models.dart';

class GetLoginWithEmail implements UseCase<User? , LoginRequest> {
  final LoginRepository loginRepository ;
  GetLoginWithEmail({required this.loginRepository});
  @override
  Future<Either<Failure, User?>> call(LoginRequest loginRequest) {
    return loginRepository.loginWithEmail(email : loginRequest.email, password : loginRequest.password);
  }
}

