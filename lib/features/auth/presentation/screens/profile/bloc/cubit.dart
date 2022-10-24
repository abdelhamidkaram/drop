import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/shared_prefs/app_prefs.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecase/profile_usecase.dart';

class ProfileCubit extends Cubit<ProfileStates>  {
  final GetProfileUseCase getProfileUseCase ;
  final AppPreferences appPreferences ;
  ProfileCubit( {required this.getProfileUseCase, required this.appPreferences,}) : super(ProfileInit());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserDetails? userDetails;
  Future profileDetails ()async {
    emit(const GetProfileDetailsLoading());
    var  response =  await getProfileUseCase(uId.toString());
    response.fold((failure){
      debugPrint(failure.message);
      emit(GetProfileDetailsError(msg: failure.message ));
    }, (userDetails ) {
      debugPrint(userDetails.refreshToken);
      emit(GetProfileDetailsSuccess(user: userDetails));
    });
  }




}