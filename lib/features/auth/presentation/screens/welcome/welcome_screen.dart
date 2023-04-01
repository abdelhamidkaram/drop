import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/referral.dart';
import 'package:dropeg/features/auth/domain/entities/user.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_states.dart';
import 'package:dropeg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_prefs/app_prefs.dart';
import '../../../../../core/utils/components/app_buttons.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../widgets/hello_there.dart';
import '../../widgets/app_social_button.dart';
import 'package:dropeg/injection_container.dart' as di;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: context.width,
                      height: 250.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(context.width * 0.3),
                          )),
                    ),
                    SizedBox(
                      width: context.width,
                      height: 650.h,
                      child: Card(
                        margin: EdgeInsets.only(
                          top: context.height / 4.5,
                          right: context.width * 0.05,
                          left: context.width * 0.05,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                  child: Image.asset(
                                ImagesManger.logoVertical,
                                height: 90.0.h,
                              )),
                              const HelloThere(
                                  subtitle: AppStrings.pleaseLoginOrSignUp),
                              Column(
                                children: [
                                  AppButtonBlue(
                                    text: AppStrings.login,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRouteStrings.login);
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  AppButtonLight(
                                    text: AppStrings.signUp,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRouteStrings.register);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 2,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Or",
                                      style:
                                          Theme.of(context).textTheme.displayMedium,
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 2,
                                    color: AppColors.grey,
                                  ))
                                ],
                              ),
                              Column(
                                children: [
                                  AppSocialButton(
                                      onTap: () async {
                                        await authCubit
                                            .registerWithFacebook()
                                            .then((value) async {
                                          if (await di
                                              .sl<AppPreferences>()
                                              .isLocationAdded()) {
                                            Navigator.pushNamed(
                                                context, AppRouteStrings.home);
                                          } else {
                                            Navigator.pushNamed(context,
                                                AppRouteStrings.location);
                                          }
                                        }).catchError((err) {
                                          debugPrint(err.toString());
                                        });
                                      },
                                      text: AppStrings.continueWithFacebook,
                                      color: AppColors.faceBookColor,
                                      icon: Icons.facebook_outlined),
                                  SizedBox(height: 8.h),
                                  Platform.isIOS
                                      ? AppSocialButton(
                                          onTap: () async {
                                            await signInWithApple(context)
                                                .then((value) async {
                                              if (value.user != null) {
                                                await FirebaseFirestore.instance
                                                    .collection(FirebaseStrings
                                                        .usersCollection)
                                                    .doc(value.user!.uid)
                                                    .get()
                                                    .then((value1) {
                                                  uId = value.user!.uid;
                                                  var user = UserDetails(
                                                    freeWashUsed: 0,
                                                    freeWashTotal: 1,
                                                    email: value.user!.email,
                                                    id: value.user!.uid,
                                                    isPhoneVerify: false,
                                                    refarCode: value.user!.uid
                                                        .substring(0, 8),
                                                    name:
                                                        value.user!.displayName,
                                                    phone: null,
                                                    photo: value.user!.photoURL,
                                                    isVerify: true,
                                                  );
                                                  authCubit.userDetails = user;
                                                  userInfo = user;

                                                  if (value1.exists) {
                                                    AppToasts.successToast(
                                                        AppStrings.success);
                                                    Navigator.pushNamed(context,
                                                        AppRouteStrings.home);
                                                  } else {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            FirebaseStrings
                                                                .usersCollection)
                                                        .doc(value.user!.uid)
                                                        .set(user.toJson());

                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            FirebaseStrings
                                                                .referralCodes)
                                                        .doc(user.refarCode)
                                                        .set(Referral(
                                                                code: user
                                                                    .refarCode,
                                                                numberOfUsed: 0,
                                                                userId: value
                                                                    .user!.uid)
                                                            .toJson())
                                                        .then((value) => debugPrint(
                                                            "referral code is saved >>> "));
                                                    AppToasts.successToast(
                                                        AppStrings.success);
                                                    Navigator.pushNamed(
                                                        context,
                                                        AppRouteStrings
                                                            .location);
                                                  }
                                                });
                                              }
                                            }).catchError((err) {
                                              debugPrint(err.toString());
                                            });
                                          },
                                          text: AppStrings.continueWithApple,
                                          color: AppColors.black,
                                          icon: Icons.apple_outlined)
                                      : AppSocialButton(
                                          onTap: () async {
                                            await authCubit
                                                .registerWithGoogle(context)
                                                .then((value) async {
                                              if (value.docs.isEmpty) {
                                                Navigator.pushNamed(context, AppRouteStrings.location);
                                              } else {
                                                Navigator.pushNamed(context, AppRouteStrings.home);
                                              }
                                            });
                                          },
                                          text: AppStrings.continueWithGmail,
                                          color: AppColors.gmailColor,
                                          icon: Icons.email_rounded),
                                ],
                              ),
                              Center(
                                  child: GestureDetector(
                                      onTap: () async {
                                        if (await AppPreferences(di.sl())
                                            .isOnBoardingScreenViewed()) {
                                          Navigator.pushReplacementNamed(
                                              context, AppRouteStrings.home);
                                        } else {
                                          Navigator.pushNamed(context,
                                              AppRouteStrings.onBoarding);
                                        }
                                      },
                                      child: Text(
                                        AppStrings.continueWithoutRegistration,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

Future<UserCredential> signInWithApple(BuildContext context) async {
  AppToasts.loadingToast();
  final appleProvider = AppleAuthProvider();
  if (kIsWeb) {
    return await FirebaseAuth.instance.signInWithPopup(appleProvider);
  } else {
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}
