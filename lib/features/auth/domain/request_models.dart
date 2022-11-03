import 'package:equatable/equatable.dart';

import 'entities/compound.dart';

class LoginRequest extends Equatable{
  final String email ;
  final String password ;
  const LoginRequest({required this.email , required this.password});
  @override
  List<Object?> get props => [email , password ];

}

class RegisterRequest extends Equatable{
  final String phone ;
  final String name ;
  final String email ;
  final String password ;
  const RegisterRequest({required this.name,required this.phone, required this.email , required this.password});
  @override
  List<Object?> get props => [email , password ];

}

class AddCompoundsToUserRequest extends Equatable {
  final String uid ;
  final List<Compound> chooseCompounds ;

  const AddCompoundsToUserRequest({required this.uid , required this.chooseCompounds});

  @override
  List<Object?> get props => [uid , chooseCompounds];

}

class ProfileDetailsRequest extends Equatable {
  final String uid;
  final bool isRefresh;
  const ProfileDetailsRequest({required this.uid , required this.isRefresh});

  @override
  List<Object?> get props => [uid , isRefresh];
}

class LocationsRequest extends Equatable {
  final String uid;
  final bool isRefresh;
  const LocationsRequest({required this.uid , required this.isRefresh});

  @override
  List<Object?> get props => [uid , isRefresh];
}

class CarsRequest extends Equatable {
  final String uid;
  final bool isRefresh;
  const CarsRequest({required this.uid , required this.isRefresh});

  @override
  List<Object?> get props => [uid , isRefresh];
}

class CompoundsRequest extends Equatable {
  final String uid;
  final bool isRefresh;
  const CompoundsRequest({required this.uid , required this.isRefresh});

  @override
  List<Object?> get props => [uid , isRefresh];
}