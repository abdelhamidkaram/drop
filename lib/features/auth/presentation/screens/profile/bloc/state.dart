import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/entities/user.dart';

abstract class ProfileStates extends Equatable {
  const ProfileStates();

  @override
  List<Object?> get props => [];
}

class ProfileInit extends ProfileStates {
  @override
  List<Object?> get props => [];
}

// profile  states  -------------------------------------------------------------|

class GetProfileDetailsLoading extends ProfileStates {
  const GetProfileDetailsLoading();

  @override
  List<Object?> get props => [];
}

class GetProfileDetailsSuccess extends ProfileStates {
  final UserDetails? user;

  const GetProfileDetailsSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetProfileDetailsError extends ProfileStates {
  final String msg;

  const GetProfileDetailsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// get locations  states  -------------------------------------------------------------|

class GetLocationsLoading extends ProfileStates {
  const GetLocationsLoading();

  @override
  List<Object?> get props => [];
}

class GetLocationsSuccess extends ProfileStates {
  final List<LocationEntity>? locations;

  const GetLocationsSuccess({required this.locations});

  @override
  List<Object?> get props => [locations];
}

class GetLocationsError extends ProfileStates {
  final String msg;

  const GetLocationsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// get Cars  states  -------------------------------------------------------------|

class GetCarsLoading extends ProfileStates {
  const GetCarsLoading();

  @override
  List<Object?> get props => [];
}

class GetCarsSuccess extends ProfileStates {
  final List<Car>? cars;

  const GetCarsSuccess({required this.cars});

  @override
  List<Object?> get props => [cars];
}

class GetCarsError extends ProfileStates {
  final String msg;

  const GetCarsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// get Compounds  states  -------------------------------------------------------------|

class GetCompoundsLoading extends ProfileStates {
  const GetCompoundsLoading();

  @override
  List<Object?> get props => [];
}

class GetCompoundsSuccess extends ProfileStates {
  final List<Compound>? compounds;

  const GetCompoundsSuccess({required this.compounds});

  @override
  List<Object?> get props => [compounds];
}

class GetCompoundsError extends ProfileStates {
  final String msg;

  const GetCompoundsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// Delete Compounds  states  -------------------------------------------------------------|

class DeleteCompoundsLoading extends ProfileStates {
  const DeleteCompoundsLoading();

  @override
  List<Object?> get props => [];
}

class DeleteCompoundsSuccess extends ProfileStates {
  @override
  List<Object?> get props => [];
}

class DeleteCompoundsError extends ProfileStates {
  final String msg;

  const DeleteCompoundsError({required this.msg});

  @override
  List<Object?> get props => [msg];
}

//-------------------- refresh

class OnRefreshData extends ProfileStates {}

//-------------------- upload image

class UploadImageSuccess extends ProfileStates {}

class UploadImageLoading extends ProfileStates {}

class UploadImageError extends ProfileStates {}

//-------------------- update account

class UpdateAccountSuccess extends ProfileStates {}

