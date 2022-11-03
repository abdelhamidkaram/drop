import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/domain/entities/referral.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import 'package:dropeg/features/auth/domain/request_models.dart';
import 'package:dropeg/features/auth/domain/usecase/login_usecase.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropeg/features/auth/domain/usecase/register_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/api/firestore_strings.dart';
import '../../../../core/utils/toasts.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';

class AuthCubit extends Cubit<AuthStates> {
  final GetRegisterWithEmail getRegisterWithEmail;
  final GetRegisterWithFaceBook getRegisterWithFaceBook;
  final GetRegisterWithGoogle getRegisterWithGoogle;
  final GetLoginWithEmail getLoginWithEmail;
  final AppPreferences appPreferences;

  AuthCubit({
    required this.appPreferences,
    required this.getLoginWithEmail,
    required this.getRegisterWithEmail,
    required this.getRegisterWithFaceBook,
    required this.getRegisterWithGoogle,
  }) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  UserDetails? userDetails;
  var fireStore = FirebaseFirestore.instance;
  //----------- Register
  Future<void> registerWithEmail(
      RegisterRequest registerRequest, BuildContext context) async {
    emit(RegisterWithEmailLoading());
    var response = await getRegisterWithEmail(registerRequest);
    response.fold((failure) {
      AppToasts.errorToast(failure.message);
      emit(RegisterWithEmailError(msg: failure.message));
    }, (user) async {
      userDetails = UserDetails(
        isVerify: user.emailVerified,
        name: registerRequest.name,
        phone: registerRequest.phone,
        email: registerRequest.email,
        id: user.uid,
        photo: user.photoURL,
        refarCode: const Uuid().v4().substring(0, 8),
      );
      _sendUserToCollection(user);
      appPreferences.deleteUserDetailsAndNotLogOut().then((value) => null);
      AppToasts.successToast(user.email.toString());
      Navigator.pushReplacementNamed(context, AppRouteStrings.location);
      await loginSuccessCache();
      emit(RegisterWithEmailSuccess(user: user));
    });
  }

  Future<void> registerWithFacebook() async {
    emit(RegisterWithFaceBookLoading());
    var response = await getRegisterWithFaceBook("");
    response.fold((failure) {
      AppToasts.errorToast(failure.message);
      emit(RegisterWithFaceBookError(msg: failure.message));
    }, (user) async {
      AppToasts.loadingToast();
      userDetails = UserDetails(
          isVerify: user.user!.emailVerified,
          name: user.user!.displayName,
          phone: user.user!.phoneNumber,
          email: user.user!.email,
          id: user.user!.uid,
          photo: user.user!.photoURL,
          refarCode: const Uuid().v4().substring(0, 8),
          isPhoneVerify: false);

      await fireStore
          .collection(FirebaseStrings.usersCollection)
          .doc(user.user!.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await _sendUserToCollection(user.user!);
        }
        await appPreferences.deleteUserDetailsAndNotLogOut();
      });
      AppToasts.successToast(
          "${AppStrings.welcome} ${user.user!.displayName ?? user.user!.email!.split("@").first}");
      await loginSuccessCache();
      RegisterWithFaceBookSuccess(user: user.user!);
    });
  }

  Future<void> registerWithGoogle() async {
   
    var response = await getRegisterWithGoogle("");
    response.fold((failure) {
      AppToasts.errorToast(failure.message);
      emit(RegisterWithGoogleError(msg: failure.message));
    }, (user) async {
       AppToasts.loadingToast();
      userDetails = UserDetails(
          isVerify: user.emailVerified,
          name: user.displayName,
          phone: user.phoneNumber,
          email: user.email,
          id: user.uid,
          photo: user.photoURL,
          refarCode: const Uuid().v4().substring(0, 8),
          isPhoneVerify: false);
      await fireStore
          .collection(FirebaseStrings.usersCollection)
          .doc(user.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await _sendUserToCollection(user);
        }
      });
      await appPreferences.deleteUserDetailsAndNotLogOut();
      AppToasts.successToast("${AppStrings.welcome} ${user.email ?? ""}");
      await loginSuccessCache();
      emit(RegisterWithGoogleSuccess(user: user));
    });
  }

//----------- login

  Future loginWithEmail(LoginRequest loginRequest, BuildContext context) async {
    emit(LoginWithEmailLoading());
    AppToasts.loadingToast();
    var response = await getLoginWithEmail.call(loginRequest);
    response.fold((failure) {
      AppToasts.errorToast(failure.message);
      emit(LoginWithEmailError(msg: failure.message));
    }, (user) async {
      AppToasts.successToast(
          "${AppStrings.welcome} ${user?.email!.split("@").first}");
      Navigator.pushReplacementNamed(context, AppRouteStrings.home);
      await loginSuccessCache();
      await appPreferences.deleteUserDetailsAndNotLogOut();

      emit(LoginWithAppleSuccess(user: user!));
    });
  }

  loginSuccessCache() async {
    await appPreferences.setUserLoggedIn();
  }

  Future _sendUserToCollection(User user) async {
    FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(user.uid)
        .set(userDetails!.toJson())
        .then((value) async {
      await _sendReferralCode(user);
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  Future<void> _sendReferralCode(User user) async {
    await FirebaseFirestore.instance
        .collection(FirebaseStrings.referralCodes)
        .doc(userDetails!.refarCode)
        .set(Referral(
            code: userDetails!.refarCode, numberOfUsed: 0, userId: user.uid)
            .toJson()).then((value) => debugPrint("referral code is saved >>> "));
  }


}
