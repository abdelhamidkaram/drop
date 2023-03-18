import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_string.dart';
import '../../../../../core/utils/components/custom_appbar.dart';
import '../../../../../core/utils/components/custom_text_field.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/toasts.dart';
import '../../../domain/request_models.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_states.dart';
import '../../widgets/sign_up_btn.dart';
import 'package:dropeg/injection_container.dart' as di;

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
    var scafflodKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scafflodKey,
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) => di.sl<AuthCubit>(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(children: [
              CustomAppbars.loginAppbar(
                  title: AppStrings.signUp, context: context),
              Column(
                children: [
                  const SizedBox(
                    height: 210,
                  ),
                  Form(
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
                                validateEmptyMSG:
                                    AppStrings.phoneNumberEmptyMSG,
                                controller: phoneController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                type: TextInputType.emailAddress,
                                hint: AppStrings.emailAddressHINT,
                                validateEmptyMSG:
                                    AppStrings.emailAddressEmptyMSG,
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
                                  if (formKey.currentState!.validate()) {
                                    showModalBottomSheet(
                                      enableDrag: true,
                                      context: context,
                                      builder: (context) => Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.cardBackGround,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25)),
                                            ),
                                            child: SizedBox(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    ImagesManger.pirvacy,
                                                    height: 116.h,
                                                  ),
                                                  const SelectedItem(
                                                    text: AppStrings.readTerms,
                                                    textGoTo:
                                                        AppStrings.gotoTerms,
                                                    url: AppConstants.termsUrl,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  const SelectedItem(
                                                    text:
                                                        AppStrings.readPrivacy,
                                                    textGoTo:
                                                        AppStrings.gotoPriv,
                                                    url:
                                                        AppConstants.privacyUrl,
                                                  ),
                                                  BlocConsumer<AuthCubit,
                                                          AuthStates>(
                                                      listener: (context,
                                                              state) =>
                                                          di.sl<AuthCubit>(),
                                                      builder:
                                                          (context, state) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: AppButtonBlue(
                                                              text: AppStrings
                                                                  .letsGo,
                                                              onTap: AuthCubit.get(
                                                                              context)
                                                                          .termsAgree ==
                                                                      2
                                                                  ? () async {
                                                                      AppToasts
                                                                          .loadingToast();
                                                                      RegisterRequest registerRequest = RegisterRequest(
                                                                          name: nameController
                                                                              .text,
                                                                          email: emailController
                                                                              .text,
                                                                          password: passwordController
                                                                              .text,
                                                                          phone:
                                                                              phoneController.text);
                                                                      await AuthCubit.get(context).registerWithEmail(
                                                                          registerRequest,
                                                                          context);
                                                                    }
                                                                  : () {
                                                                      AppToasts.errorToast(
                                                                          AppStrings
                                                                              .mustAgreeTerms);
                                                                    }),
                                                        );
                                                      })
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close)),
                                        ],
                                      ),
                                    ).then((value) =>
                                        AuthCubit.get(context).termsAgree = 0);
                                  }
                                },
                                editOnPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
        },
      ),
    );
  }
}

class SelectedItem extends StatefulWidget {
  final String text;
  final String textGoTo;
  final String url;
  const SelectedItem({
    Key? key,
    required this.url,
    required this.text,
    required this.textGoTo,
  }) : super(key: key);

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  bool isSelect = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSelect = !isSelect;
                AuthCubit.get(context).getChangeTerms(isSelect);
              });
            },
            child: Card(
              child: Container(
                height: 25.h,
                width: 25.h,
                decoration: BoxDecoration(
                  color: isSelect ? AppColors.primaryColor : AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isSelect
                    ? Icon(
                        Icons.check_sharp,
                        color: AppColors.white,
                      )
                    : SizedBox(),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.black),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrowserScreen(url: widget.url),
                  ));
            },
            child: Text(
              widget.textGoTo,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryColor,
                    textBaseline: TextBaseline.ideographic,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
