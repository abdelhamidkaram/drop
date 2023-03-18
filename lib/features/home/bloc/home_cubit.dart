import 'package:dropeg/core/usecase/usecase.dart';
import 'package:dropeg/core/utils/extensions.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/home/features/services/domain/entity/service_entity.dart';
import 'package:dropeg/features/home/features/services/domain/usecase/serviec_usecase.dart';
import 'package:dropeg/features/home/bloc/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  final ServiceUseCase serviceUseCase;
  HomeCubit({required this.serviceUseCase}) : super(HomeStateInit());
  static HomeCubit get(context) => BlocProvider.of(context);

  LocationEntity? mainLocation;

  getMainLocation({required BuildContext context, LocationEntity? location}) {
    emit(GetMainLocationloading());
    if (location == null) {
      if (ProfileCubit.get(context).locations?.isNotEmpty ?? false) {
        mainLocation = ProfileCubit.get(context).locations?.first;
      } else {
        if (ProfileCubit.get(context).compounds?.isNotEmpty ?? false) {
          var compound = ProfileCubit.get(context).compounds?.first;
          mainLocation = compound!.toLocationEntity();
          HomeCubit.get(context).getMainLocation(
            context: context,
            location: compound.toLocationEntity(),
          );
        }
      }
    } else {
      mainLocation = location;
    }
    emit(GetMainLocationSuccess());
  }

  List<ServiceEntity> services = [];
  Future getServices() async {
    emit(GetServicesLoading());
    var response = await serviceUseCase(NoPrams());
    emit(response.fold((failure) => GetServicesError(msg: failure.message),
        (services) {
      this.services = services;
      return GetServicesSuccess(services: services);
    }));
  }
}
