import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/request_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../core/utils/components/app_buttons.dart';
import '../../../../../core/utils/components/custom_appbar.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var emailResetController = TextEditingController();
    var passwordController = TextEditingController();
    var loginKey = GlobalKey<FormState>();
    return Scaffold(
         body: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
                children: [
                CustomAppbars.loginAppbar(
                  title: AppStrings.login, context: context, isLoginScreen: true),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      key: loginKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            hint: AppStrings.emailAddressHINT,
                            controller: emailController,
                            validateEmptyMSG: AppStrings.emailAddressEmptyMSG,
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextFormField(
                            hint: AppStrings.passwordHINT,
                            controller: passwordController,
                            validateEmptyMSG: AppStrings.passwordEmptyMSG,
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                              onTap: () {
                                var _formkey = GlobalKey<FormState>();
                                showBottomSheet(
                                  enableDrag: true,
                                  context: context,
                                  builder: (context) => Container(
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.greyLight, width: 2),
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Form(
                                        key: _formkey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Send a password reset link",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
                                            ),
                                            CustomTextFormField(
                                              hint: AppStrings.emailAddressHINT,
                                              controller: emailResetController,
                                              validateEmptyMSG:
                                                  AppStrings.emailAddressEmptyMSG,
                                              type: TextInputType.emailAddress,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: AppButtonBlue(
                                                      text: "Send",
                                                      onTap: () async {
                                                        if (_formkey.currentState!
                                                            .validate()) {
                                                          await FirebaseAuth
                                                              .instance
                                                              .sendPasswordResetEmail(
                                                                  email:
                                                                      emailResetController
                                                                          .text)
                                                              .then((value) {
                                                            AppToasts.successToast(
                                                                AppStrings.success);
                                                            Navigator.pop(context);
                                                          }).catchError((error) {
                                                            AppToasts.errorToast(
                                                                error
                                                                    .toString()
                                                                    .split(']')
                                                                    .last);
                                                          });
                                                        }
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Expanded(
                                                  child: AppButtonRed(
                                                      text: AppStrings.cancel,
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      }),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(AppStrings.forgetPassword)),
                          const SizedBox(
                            height: 16,
                          ),
                          AppButtonBlue(
                            onTap: () async {
                              if (loginKey.currentState!.validate()) {
                                LoginRequest loginRequest = LoginRequest(
                                    email: emailController.text,
                                    password: passwordController.text);
                                await AuthCubit.get(context)
                                    .loginWithEmail(loginRequest, context);
                              }
                            },
                            text: AppStrings.login,
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
