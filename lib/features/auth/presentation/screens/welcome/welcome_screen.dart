import 'dart:io' show Platform;
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:dropeg/features/auth/presentation/cubits/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_prefs/app_prefs.dart';
import '../../../../../core/utils/components/app_buttons.dart';
import '../../../../../core/utils/assets_manger.dart';
import '../../../../../main.dart';
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
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (kDebugMode) {
                print(token);
              }
            },
          ),
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
                              // const SizedBox(
                              //   height: 32,
                              // ),
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
                              // const SizedBox(height: 32),
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
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 2,
                                    color: AppColors.grey,
                                  ))
                                ],
                              ),
                              // const SizedBox(height: 32),
                              Column(
                                children: [
                                  AppSocialButton(
                                      onTap: () async {
                                        await authCubit
                                            .registerWithFacebook()
                                            .then((value) {
                                          if (state
                                              is RegisterWithFaceBookSuccess) {
                                            Navigator.pushNamed(context,
                                                AppRouteStrings.location);
                                          }
                                        });
                                      },
                                      text: AppStrings.continueWithFacebook,
                                      color: AppColors.faceBookColor,
                                      icon: Icons.facebook_outlined),
                                  SizedBox(height: 8.h),
                                  Platform.isIOS
                                      ? AppSocialButton(
                                          onTap: () async {
                                            await signInWithApple()
                                                .then((value) {
                                              Navigator.pushNamed(context,
                                                  AppRouteStrings.location);
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
                                                .registerWithGoogle()
                                                .then((value) {
                                              Navigator.pushNamed(context,
                                                  AppRouteStrings.location);
                                            }).catchError((err) {
                                              debugPrint(err.toString());
                                            });
                                          },
                                          text: AppStrings.continueWithGmail,
                                          color: AppColors.gmailColor,
                                          icon: Icons.email_rounded),
                                ],
                              ),
                              // const SizedBox(height: 32),
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
                                            .headline5,
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

Future<UserCredential> signInWithApple() async {
  final appleProvider = AppleAuthProvider();
  if (kIsWeb) {
    return await FirebaseAuth.instance.signInWithPopup(appleProvider);
  } else {
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }
}
