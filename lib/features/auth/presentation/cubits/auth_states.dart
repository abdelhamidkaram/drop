import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

 abstract class AuthStates extends Equatable{
  const AuthStates();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthStates{}

class ChangeTermsAgreeSuccess extends AuthStates{}
class ChangeTermsAgreeLoading extends AuthStates{}


// register states -------------------------------------------------------------|


class RegisterWithGoogleLoading extends AuthStates{}
class RegisterWithGoogleSuccess extends AuthStates{

  final User user ;

  const RegisterWithGoogleSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class RegisterWithGoogleError extends AuthStates{

  final String msg ;

  const RegisterWithGoogleError({required this.msg});

 @override
  List<Object?> get props => [msg];
}

class RegisterWithFaceBookLoading extends AuthStates{}
class RegisterWithFaceBookSuccess extends AuthStates{

  final User user ;

  const  RegisterWithFaceBookSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class RegisterWithFaceBookError extends AuthStates{

 final String msg ;

 const RegisterWithFaceBookError({required this.msg});

 @override
 List<Object?> get props => [msg];
}

class RegisterWithAppleLoading extends AuthStates{}
class RegisterWithAppleSuccess extends AuthStates{

  final User user ;

  const RegisterWithAppleSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class RegisterWithAppleError extends AuthStates{

 final String msg ;

 const RegisterWithAppleError({required this.msg});

 @override
 List<Object?> get props => [msg];
}

class RegisterWithEmailLoading extends AuthStates{}
class RegisterWithEmailSuccess extends AuthStates{

 final User user ;

 const RegisterWithEmailSuccess({required this.user});

 @override
 List<Object?> get props => [user];
}
class RegisterWithEmailError extends AuthStates{

 final String msg ;

 const RegisterWithEmailError({required this.msg});

 @override
 List<Object?> get props => [msg];
}

// login states  -------------------------------------------------------------|
class LoginWithGoogleLoading extends AuthStates{}
class LoginWithGoogleSuccess extends AuthStates{

  final User user ;

  const LoginWithGoogleSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class LoginWithGoogleError extends AuthStates{

  final String msg ;

  const LoginWithGoogleError({required this.msg});

 @override
  List<Object?> get props => [msg];
}

class LoginWithFaceBookLoading extends AuthStates{}
class LoginWithFaceBookSuccess extends AuthStates{

  final User user ;

  const  LoginWithFaceBookSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class LoginWithFaceBookError extends AuthStates{

 final String msg ;

 const LoginWithFaceBookError({required this.msg});

 @override
 List<Object?> get props => [msg];
}

class LoginWithAppleLoading extends AuthStates{}
class LoginWithAppleSuccess extends AuthStates{

  final User user ;

  const LoginWithAppleSuccess({required this.user});

 @override
  List<Object?> get props => [user];
}
class LoginWithAppleError extends AuthStates{

 final String msg ;

 const LoginWithAppleError({required this.msg});

 @override
 List<Object?> get props => [msg];
}

class LoginWithEmailLoading extends AuthStates{}
class LoginWithEmailSuccess extends AuthStates{

 final User user ;

 const LoginWithEmailSuccess({required this.user});

 @override
 List<Object?> get props => [user];
}
class LoginWithEmailError extends AuthStates{

 final String msg ;

 const LoginWithEmailError({required this.msg});



 @override
 List<Object?> get props => [msg];
}

