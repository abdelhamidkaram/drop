import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/features/auth/domain/request_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var passwordController = TextEditingController();
    var loginKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppbars.loginAppbar(title: AppStrings.login,
          context: context,
          height: 233,
          isLoginScreen: true),
      body: BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: loginKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      hint: AppStrings.emailAddressHINT,
                      controller: emailController,
                      validateEmptyMSG: AppStrings.emailAddressEmptyMSG,
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32,),
                    CustomTextFormField(
                      hint: AppStrings.passwordHINT,
                      controller: passwordController,
                      validateEmptyMSG: AppStrings.passwordEmptyMSG,
                      type: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32,),
                    AppButtonBlue(
                      onTap: () async {
                        if(loginKey.currentState!.validate()){
                          LoginRequest loginRequest = LoginRequest(
                              email: emailController.text, password: passwordController.text);
                          await AuthCubit.get(context).loginWithEmail(loginRequest , context);
                        }
                      },
                      text: AppStrings.login,
                    )

                  ],
                ),
              )),
        );
      },),
    );
  }
}
