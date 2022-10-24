import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/features/auth/presentation/screens/register/register_compound/bloc/compound_register_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/compound.dart';

class CompoundCubit extends Cubit<CompoundRegisterStates> {
  CompoundCubit() : super(CompoundRegisterInit());
static CompoundCubit get(context) => BlocProvider.of(context);
List<Compound> compounds = [];
List<Compound> choseCompounds = [];

  getCompounds() async {
    emit(CompoundRegisterLoading());
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.compoundsCollection)
        .get()
        .then((value) {
      compounds = value.docs.map((e){
            return Compound.formJson(e.data());
          }).toList();
      emit(CompoundRegisterSuccess());
        }).catchError((err) {
      emit(CompoundRegisterSuccess());
      if (kDebugMode) {
        print(err.toString());
      }
    });
  }
}
