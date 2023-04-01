import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/constant.dart';
import 'package:dropeg/features/auth/data/mapper.dart';
import 'package:dropeg/features/auth/domain/entities/referral.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import 'package:dropeg/features/auth/domain/request_models.dart';
import 'package:dropeg/features/auth/domain/usecase/login_usecase.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_states.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropeg/features/auth/domain/usecase/register_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/api/firestore_strings.dart';
import '../../../../core/utils/toasts.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';

import '../../data/models/user_model.dart';

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

  int termsAgree = 0;

  getChangeTerms(bool isSelected) {
    emit(ChangeTermsAgreeLoading());
    if (isSelected) {
      termsAgree += 1;
    } else {
      termsAgree -= 1;

    }
    emit(ChangeTermsAgreeSuccess());
  }

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
        freeWashUsed: 0,
        freeWashTotal: AppConstants.freeWashTotal,
        isVerify: user.emailVerified,
        name: registerRequest.name,
        phone: registerRequest.phone,
        email: registerRequest.email,
        id: user.uid,
        photo: user.photoURL,
        refarCode: const Uuid().v4().substring(0, 8),
      );
      userInfo = userDetails;
      sendUserToCollection(user);
      appPreferences.deleteUserDetailsAndNotLogOut().then((value) => null);
      AppToasts.successToast(user.email.toString());
      Navigator.pushReplacementNamed(context, AppRouteStrings.location);
      await loginSuccessCache();
      emit(RegisterWithEmailSuccess(user: user));
    });
  }

  Future<void> registerWithFacebook() async {
    AppToasts.loadingToast();
    emit(RegisterWithFaceBookLoading());
    var response = await getRegisterWithFaceBook("");
    response.fold((failure) {
      AppToasts.errorToast(failure.message);
      emit(RegisterWithFaceBookError(msg: failure.message));
    }, (user) async {
      userDetails = UserDetails(
        isVerify: user.user!.emailVerified,
        name: user.user!.displayName,
        phone: user.user!.phoneNumber,
        email: user.user!.email,
        id: user.user!.uid,
        photo: user.user!.photoURL,
        refarCode: const Uuid().v4().substring(0, 8),
        isPhoneVerify: false,
        freeWashUsed: 0,
        freeWashTotal: AppConstants.freeWashTotal,
      );
      userInfo = userDetails;
      await fireStore
          .collection(FirebaseStrings.usersCollection)
          .doc(user.user!.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await sendUserToCollection(user.user!);
        }
        await appPreferences.deleteUserDetailsAndNotLogOut();
      });
      AppToasts.successToast(
          "${AppStrings.welcome} ${user.user!.displayName ?? user.user!.email!.split("@").first}");
      await loginSuccessCache();
      RegisterWithFaceBookSuccess(user: user.user!);
    });
  }

  Future registerWithGoogle(BuildContext context) async {
    signInWithGoogle().then((user) async {
      if (user.user != null) {
        uId = user.user!.uid;
        var userNew = UserDetails(
          email: user.user!.email,
          id: user.user!.uid,
          isPhoneVerify: false,
          refarCode: user.user!.uid.substring(0, 8),
          name: user.user!.displayName,
          phone: null,
          photo: user.user!.photoURL,
          isVerify: true,
          freeWashUsed: 0,
          freeWashTotal: AppConstants.freeWashTotal,
        );
        userDetails = userNew;
        userInfo = userNew;
        await FirebaseFirestore.instance
            .collection(FirebaseStrings.usersCollection)
            .doc(user.user!.uid)
            .get()
            .then((value1) async {
          if (!value1.exists) {
            await sendUserToCollection(user.user!);
            await loginSuccessCache();
          }
          await appPreferences.deleteUserDetailsAndNotLogOut();
          await fireStore
              .collection(FirebaseStrings.usersCollection)
              .doc(user.user!.uid)
              .collection(FirebaseStrings.locationsCollection)
              .get()
              .then((value) async {
            AppToasts.successToast(
                "${AppStrings.welcome} ${user.user!.displayName ?? user.user!.email!.split("@").first}");
            await loginSuccessCache();
            if (value.docs.isEmpty) {
              Navigator.pushNamed(context, AppRouteStrings.location);
            } else {
              Navigator.pushNamed(context, AppRouteStrings.home);
            }
          });
        });
      }
    }).catchError((err) {
      AppToasts.errorToast(AppStrings.errorInternal);
      debugPrint(err.toString());
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

      if (user != null) {
        await FirebaseFirestore.instance
            .collection(FirebaseStrings.usersCollection)
            .doc(user.uid)
            .get()
            .then((value1) async {
          if (!value1.exists) {
            await sendUserToCollection(user);
          }
          await appPreferences.deleteUserDetailsAndNotLogOut();

          var userNew = UserDetailsModel.formJson(value1.data()!).toDomain();
          userDetails = userNew;
          userInfo = userNew;
          uId=userNew.id!;
          ProfileCubit.get(context).getProfileDetails(firstbuild: true , isRefresh: true).then((value) async {
            AppToasts.successToast(
                "${AppStrings.welcome} ${user.displayName ?? user.email!.split("@").first}");
            await loginSuccessCache().whenComplete(() {
              Navigator.pushReplacementNamed(context, AppRouteStrings.home);
              emit(LoginWithEmailSuccess(user: user));
          });

          });

        });
      }

    });
  }

  Future loginSuccessCache() async {
    await appPreferences.setUserLoggedIn();
  }

//-----------
  Future sendUserToCollection(User user) async {
    FirebaseFirestore.instance
        .collection(FirebaseStrings.usersCollection)
        .doc(user.uid)
        .set(userDetails!.toJson())
        .then((value) {
      _sendReferralCode(user).then((value) => null);
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
            .toJson())
        .then((value) {
      userInfo = userDetails;
      debugPrint("referral code is saved >>> ");
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    AppToasts.loadingToast();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
