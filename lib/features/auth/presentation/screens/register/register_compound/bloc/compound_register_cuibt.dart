import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_states.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/compound.dart';
import '../../../../../domain/usecase/compound_usecase.dart';
import '../../../../../domain/request_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompoundCubit extends Cubit<CompoundRegisterStates> {
  final GetCompoundUseCase getCompoundUseCase;
  final AddCompoundToUserUseCase addCompoundToUserUseCase;
  CompoundCubit( {required this.addCompoundToUserUseCase, required this.getCompoundUseCase}) : super(CompoundRegisterInit());
static CompoundCubit get(context) => BlocProvider.of(context);
List<Compound> compounds = [];
List<Compound> chooseCompounds = [];


  getCompounds() async {
    emit(CompoundRegisterLoading());
    await FirebaseFirestore.instance
    .collection(FirebaseStrings.compoundsCollection)
    .get()
    .then((value) {
      debugPrint("${value.docs.length}");
      compounds = value.docs.map((e) => Compound.formJson(e.data())).toList();
      emit(CompoundRegisterSuccess());
    }).catchError((err){
      if (kDebugMode) {
        print(err.toString());
      }
      emit(CompoundRegisterError());
    });
  }

  Future<bool>addCompoundsToUser()async {

    (await addCompoundToUserUseCase(AddCompoundsToUserRequest(uid: uId, chooseCompounds: chooseCompounds)))
        .fold(
            (failure) {
              AppToasts.errorToast(AppStrings.pleaseChooseAnyCompound);
             return  false;
            } ,
            (success){
              if(success){
                AppToasts.successToast(AppStrings.success);
                return success ;
              }
            });
    return false ;
  }

}
