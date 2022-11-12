import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/presentation/widgets/provider_build_item.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'provider_services_state.dart';

class ProviderServicesCubit extends Cubit<ProviderServicesState> {
  ProviderServicesCubit() : super(ProviderServicesInitial());
  static ProviderServicesCubit get(context) => BlocProvider.of(context);
  var commentController = TextEditingController();
  int totalPrice = 0;
  String service = AppStrings.service;

  String selectedTime = DateTime.now().add(const Duration(days: 1)).toString();
  changeSelectedTime(DateTime newTime) {
    emit(ChangeSelectedDayLoading());
    selectedTime = newTime.toString();
    emit(ChangeSelectedDaySuccess());
  }

  ServiceProvider? selectedProvider;
  ServiceProvideList? selectedProviderServices;

  changeSelectedProvider(ServiceProvider serviceProvider) {
    emit(ChangeSelectedProviderLoading());
    selectedProvider = serviceProvider;
    emit(ChangeSelectedProviderSuccess());
  }
  
    changeSelectedProviderServices(ServiceProvideList? selectedProviderServices) {
    emit(ChangeSelectedProviderLoading());
    this.selectedProviderServices = selectedProviderServices;
    emit(ChangeSelectedProviderSuccess());
  }

  var data = {};
  String serviceUuid = "";
  Future confirmAppointment(ServiceProvideList? serviceProvideList) async {
    emit(ConfirmAppointmentLoading());

  }
}
