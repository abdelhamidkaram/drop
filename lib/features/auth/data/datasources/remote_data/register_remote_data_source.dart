import 'package:dartz/dartz.dart';
import 'package:dropeg/core/error/failure.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../main.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failure, User>> registerWithEmail(
      String email, String password);

  Future<Either<Failure, User>> registerWithGoogle();

  Future<Either<Failure, UserCredential>> registerWithFacebook();
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final AppPreferences appPreferences;

  RegisterRemoteDataSourceImpl(this.appPreferences);

  @override
  Future<Either<Failure, User>> registerWithEmail(
      String email, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uId = credential.user?.uid ?? "";
      await appPreferences.loginAllCache(token, uId);
      return Right(credential.user!);
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
      return Left(ServerFailure(
          message: err.toString().split("]").last,
          code: AppErrorValues.serverErrorCode));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]);
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      var userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      uId = userCredential.user?.uid ?? "";
      await appPreferences.loginAllCache(token, uId);
      return Right(userCredential);
    } catch (err) {
      return const Left(ServerFailure(
          code: AppErrorValues.serverErrorCode,
          message: AppStrings.errorInternal));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
       if (googleUser == null) {
       return const Left(ServerFailure(
          code: AppErrorValues.serverErrorCode,
          message: ""));
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      uId = userCredential.user?.uid ?? "";
      await appPreferences.loginAllCache(token, uId);
      debugPrint(userCredential.user!.email);
     
      return Right(userCredential.user!);
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
      return Left(ServerFailure(
          code: AppErrorValues.serverErrorCode,
          message: err.toString().split("]").last.toString()));
    }
  }
}
