import 'package:dropeg/features/home/presentation/bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeStateInit());
  static HomeCubit get(context) => BlocProvider.of(context);

}