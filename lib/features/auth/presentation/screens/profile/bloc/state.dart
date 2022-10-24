import 'package:equatable/equatable.dart';

import '../../../../domain/entities/user.dart';

abstract class ProfileStates  extends Equatable{
   const ProfileStates();
  @override
  List<Object?> get props => [];
}

class ProfileInit extends ProfileStates{
  @override
  List<Object?> get props => [];
}

// profile  states  -------------------------------------------------------------|

class GetProfileDetailsLoading extends ProfileStates{

  const GetProfileDetailsLoading();
  @override
  List<Object?> get props => [];
}
class GetProfileDetailsSuccess extends ProfileStates{

  final UserDetails user ;

    GetProfileDetailsSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}
class GetProfileDetailsError extends ProfileStates{

  final String msg ;

   GetProfileDetailsError({required this.msg});

  @override
  List<Object?> get props => [msg];


}
