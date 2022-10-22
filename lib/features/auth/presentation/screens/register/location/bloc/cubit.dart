import 'package:bloc/bloc.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationStates>{
  LocationCubit() : super(InitState()) ;

  static LocationCubit get(context)=> BlocProvider.of(context);

  String? locationType;
  String? locationState;
  String? city;


}