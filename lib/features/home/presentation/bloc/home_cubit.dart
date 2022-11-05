import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/home/presentation/bloc/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStateInit());
    static HomeCubit get(context) => BlocProvider.of(context);

  LocationEntity? mainLocation;

  getMainLocation({required BuildContext context, LocationEntity? location}) {
    emit(GetMainLocationloading());
    if (location == null) {
      mainLocation = ProfileCubit.get(context).locations?.first;
    } else {
      mainLocation = location ; 
    }
    emit(GetMainLocationSuccess());
  }

  
}
