import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../config/route/app_route.dart';
import '../../../../../../../core/api/firestore_strings.dart';
import '../../../../../../../core/shared_prefs/app_prefs.dart';
import '../../../../../../../core/utils/app_string.dart';
import '../../../../../../../core/utils/toasts.dart';
import '../../../../../../../main.dart';
import '../../../../../domain/entities/location.dart';
import 'package:dropeg/injection_container.dart' as di;
import '../../../profile/bloc/cubit.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(InitState());

  static LocationCubit get(context) => BlocProvider.of(context);

  String? locationType;
  String? locationState;
  String? city;

  Future addLocation(BuildContext context, bool formProfileScreen,
      LocationEntity location) async {
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(FirebaseStrings.locationsCollection)
        .doc(location.id)
        .set(location.toJson())
        .then((value) {
      di.sl<AppPreferences>().setLocationAdded().then((value) {
        AppToasts.successToast(AppStrings.success);
        if (formProfileScreen) {
          di
              .sl<ProfileCubit>()
              .getLocations(isRefresh: true)
              .then((value) => null);
          Navigator.of(context).pushReplacementNamed(AppRouteStrings.account);
        } else {
          Navigator.of(context).pushNamed(AppRouteStrings.addCar);
        }
      });
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  Future editLocation(
      LocationEntity locationEntity, LocationEntity newLocationEntity) async {
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.locationsCollection)
        .doc(locationEntity.id)
        .update(newLocationEntity.toJson())
        .then((value) {
      AppToasts.successToast(AppStrings.success);
    }).catchError((err) {
      debugPrint(err.toString());

      AppToasts.errorToast(AppStrings.errorInternal);
    });
  }

  Future deleteLocation(String locationId, BuildContext context) async {
    AppToasts.loadingToast();
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.locationsCollection)
        .doc(locationId)
        .delete()
        .then((value) {
       ProfileCubit.get(context)
          .getLocations(isRefresh: true)
          .whenComplete(() {
             AppToasts.successToast(AppStrings.deleted);
          });
      
    }).catchError((err) {
      AppToasts.errorToast(AppStrings.errorInternal);
    });
  }
}
