import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/compound.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:dropeg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../config/route/app_route.dart';
import '../../../../../../core/shared_prefs/app_prefs.dart';
import '../../../../domain/entities/car.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/request_models.dart';
import '../../../../domain/usecase/car_usecase.dart';
import '../../../../domain/usecase/compound_usecase.dart';
import '../../../../domain/usecase/locations_usecase.dart';
import '../../../../domain/usecase/profile_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileCubit extends Cubit<ProfileStates> {
  final GetProfileUseCase getProfileUseCase;
  final AppPreferences appPreferences;
  final LocationUseCase locationUseCase;
  final CarsUseCase carsUseCase;
  final GetCompoundUseCase getCompoundUseCases;

  ProfileCubit({
    required this.getCompoundUseCases,
    required this.carsUseCase,
    required this.locationUseCase,
    required this.getProfileUseCase,
    required this.appPreferences,
  }) : super(ProfileInit());
  List<LocationEntity>? locations = [];

  List<Car>? cars = [];

  List<Compound>? compounds = [];

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserDetails? userDetails;

  Future getProfileDetails({bool isRefresh = false}) async {
    if(userDetails == null ){
emit(const GetProfileDetailsLoading());
    var response = await getProfileUseCase(
        ProfileDetailsRequest(isRefresh: isRefresh, uid: uId));
    response.fold((failure) {
      debugPrint("profileDetails Error ");
      emit(GetProfileDetailsError(msg: failure.message));
    }, (userDetails) {
      this.userDetails = userDetails;
      emit(GetProfileDetailsSuccess(user: userDetails));
    });
    }
  }

  Future<bool> updateProfileDetails(UserDetails newUserDetails) async {
    bool isUpdate = false;
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .update(newUserDetails.toJson())
        .then((value) {
      getProfileDetails(isRefresh: true).then((value) => null);
      AppToasts.successToast(AppStrings.success);
      emit(UpdateAccountSuccess());
      isUpdate = true;
    }).catchError((err) {
      debugPrint(err.toString());
      AppToasts.errorToast(AppStrings.errorInternal);
      isUpdate = false;
    });
    return isUpdate;
  }

  Future getLocations({bool isRefresh = false}) async {
    emit(const GetLocationsLoading());
    (await locationUseCase(LocationsRequest(uid: uId, isRefresh: isRefresh)))
        .fold((failure) => emit(GetLocationsError(msg: failure.message)),
            (locations) async {
      if (locations.isNotEmpty) {
        this.locations = locations;
      }
      emit(GetLocationsSuccess(locations: locations));
    });
  }

  Future getCompounds({bool isRefresh = false}) async {
    emit(const GetCompoundsLoading());
    (await getCompoundUseCases(
            CompoundsRequest(uid: uId, isRefresh: isRefresh)))
        .fold(
      (failure) => emit(GetCompoundsError(msg: failure.message)),
      (compounds) {
        this.compounds = compounds;
        emit(GetCompoundsSuccess(compounds: compounds));
      },
    );
  }

  Future getDeleteCompounds(compoundId) async {
    emit(const DeleteCompoundsLoading());
    FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.compoundsCollection)
        .doc(compoundId)
        .delete()
        .then((value) async {
      await getCompounds(isRefresh: true);
      AppToasts.successToast(AppStrings.deleted);
      emit(DeleteCompoundsSuccess());
    }).catchError((err) {
      AppToasts.errorToast(AppStrings.errorInternal);
      emit(const DeleteCompoundsError(msg: AppStrings.errorInternal));
    });
  }

  Future getCars({bool isRefresh = false}) async {
    emit(const GetCarsLoading());
    (await carsUseCase(CarsRequest(uid: uId, isRefresh: isRefresh)))
        .fold((failure) => emit(GetCarsError(msg: failure.message)), (cars) {
      if (cars.isNotEmpty) {
        this.cars = cars;
      }
      emit(GetCarsSuccess(cars: cars));
    });
  }

  Future refreshData() async {
    getLocations(isRefresh: true).then((value) {
      emit(OnRefreshData());
      getCompounds(isRefresh: true).then((value) {
        emit(OnRefreshData());
        getCars(isRefresh: true).then((value) => emit(OnRefreshData()));
      });
      emit(OnRefreshData());
    });
  }

  Future sendPhone(String phone) async {
    emit(SendPhoneLoading());
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.usersCollection)
          .doc(uId)
          .update({FirebaseStrings.phoneField: phone});
      await getProfileDetails(isRefresh: true);
      emit(SendPhoneSuccess());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(SendPhoneError());
    }
  }

  Future deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete().then((value) async {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.usersCollection)
          .doc(uId)
          .delete()
          .then((value) {
        uId = "";
      });
      await appPreferences.deleteUserDetailsAndLogOut();
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }

  Future deleteCar({required int index, required BuildContext context}) async {
    FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.carCollection)
        .doc(cars![index].id)
        .delete()
        .then((value) {
      ProfileCubit.get(context).getCars(isRefresh: true).then((value) {
        Navigator.pushReplacementNamed(context, AppRouteStrings.account);
        AppToasts.successToast(AppStrings.deleted);
      });
    }).catchError((err) {
      AppToasts.errorToast(AppStrings.errorInternal);
    });
  }

  Future getEditCar(
      {required int index,
      required Car newCar,
      required BuildContext context}) async {
    AppToasts.loadingToast();
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(uId)
        .collection(FirebaseStrings.carCollection)
        .doc(cars![index].id)
        .update(newCar.toJson())
        .then((value) async {
      await ProfileCubit.get(context).getCars(isRefresh: true).then((value) {
        AppToasts.successToast(AppStrings.success);
        Navigator.pushReplacementNamed(context, AppRouteStrings.account);
      });
    }).catchError((error) {
      AppToasts.successToast(AppStrings.errorInternal);
      Navigator.pop(context);
    });
  }

  Future uploadProfileImg(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        AppToasts.loadingToast();
        emit(UploadImageLoading());
        await firebase_storage.FirebaseStorage.instance
            .ref()
            .child("users/$uId/${Uri.file(image.path).pathSegments.last}")
            .putFile(File(image.path))
            .then((p0) async => {
                  FirebaseFirestore.instance
                      .collection(FirebaseStrings.usersCollection)
                      .doc(uId)
                      .update(UserDetails(
                        id: userDetails!.id,
                        email: userDetails!.email,
                        phone: userDetails!.phone,
                        isPhoneVerify: userDetails!.isPhoneVerify,
                        isVerify: userDetails!.isVerify,
                        photo: await p0.ref.getDownloadURL(),
                        name: userDetails!.name,
                        refarCode: userDetails?.refarCode ?? "",
                      ).toJson())
                      .then((value) {
                    getProfileDetails(isRefresh: true).then((value) {
                      AppToasts.successToast(AppStrings.success);
                      emit(UploadImageSuccess());
                    });
                  })
                });
      } else {
        return;
      }
    } catch (err) {
      debugPrint(err.toString());
      AppToasts.errorToast(AppStrings.errorInternal);
      emit(UploadImageError());
    }
  }
}
