import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../core/utils/components/custom_appbar.dart';
import '../../../../../core/utils/components/custom_text_field.dart';
import '../../../../../core/utils/toasts.dart';
import '../../../domain/request_models.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_states.dart';
import '../../widgets/sign_up_btn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppbars.loginAppbar(title: AppStrings.signUp, context: context),
        body:  BlocBuilder<AuthCubit , AuthStates>(
          builder: (context, state) {
            return  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            type: TextInputType.name,
                            controller: nameController,
                            hint: AppStrings.firstNameHINT,
                            validateEmptyMSG: AppStrings.firstNameEmptyMSG,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            isPhone: true,
                            type: TextInputType.phone,
                            hint: AppStrings.phoneNumberHINT,
                            validateEmptyMSG: AppStrings.phoneNumberEmptyMSG,
                            controller: phoneController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            type: TextInputType.emailAddress,
                            hint: AppStrings.emailAddressHINT,
                            validateEmptyMSG: AppStrings.emailAddressEmptyMSG,
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            isPassword: true,
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            hint: AppStrings.passwordHINT,
                            validateEmptyMSG: AppStrings.passwordEmptyMSG,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          SignUpBTN(
                              value: 0.75,
                              onTap: () async {
                              if(formKey.currentState!.validate()){
                                AppToasts.loadingToast();
                                RegisterRequest registerRequest = RegisterRequest(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text
                                );
                               await  AuthCubit.get(context).registerWithEmail(registerRequest , context );
                              }
                              }, editOnPressed: () {  },),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),


    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // final lowPoint = size.height - 30;
    // final highPoint = size.height -40;
    // path.lineTo(0, size.height / 3);
    // path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    // path.quadraticBezierTo(
    //     3 / 4 * size.width, size.height, size.width, lowPoint);
    // path.lineTo(size.width, 0);

    path.lineTo(100, 0);
    path.lineTo(0, 100);
    path.arcToPoint(const Offset(10, 100));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
