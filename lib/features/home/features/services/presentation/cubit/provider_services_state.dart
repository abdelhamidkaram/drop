part of 'provider_services_cubit.dart';

abstract class ProviderServicesState extends Equatable {
  const ProviderServicesState();

  @override
  List<Object> get props => [];
}

class ProviderServicesInitial extends ProviderServicesState {}


//------------
class ChangeServiceProviderSuccess extends ProviderServicesState {}
class ChangeServiceProviderLoading extends ProviderServicesState {}
 
//-------
class ChangeSelectedDaySuccess extends ProviderServicesState {}
class ChangeSelectedDayLoading extends ProviderServicesState {}

//-------
class ChangeSelectedProviderSuccess extends ProviderServicesState {}
class ChangeSelectedProviderLoading extends ProviderServicesState {}

//-------
class ChangeSelectedProviderListSuccess extends ProviderServicesState {}
class ChangeSelectedProviderListLoading extends ProviderServicesState {}

//-------
class GetServiceProvideListLoading extends ProviderServicesState {}
class GetServiceProvideListSuccess extends ProviderServicesState {}

//-------
class ConfirmAppointmentSuccess extends ProviderServicesState {}
class ConfirmAppointmentLoading extends ProviderServicesState {}
class ConfirmAppointmentError extends ProviderServicesState {}
