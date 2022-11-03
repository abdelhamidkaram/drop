import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropeg/injection_container.dart' as di;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/route/app_route.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_string.dart';
import '../../../../../../core/utils/assets_manger.dart';
import '../../../../../../core/utils/toasts.dart';
import '../../../../domain/entities/user.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfileDetails().then((value) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRouteStrings.account);
        return Future.value(true);
      },
      child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) => di.sl<ProfileCubit>(),
          builder: (context, state) {
            return Scaffold(
                backgroundColor: AppColors.white,
                appBar: CustomAppbars.loginAppbar(
                    title: AppStrings.editAccount,
                    isEditAccountScreen: true,
                    context: context),
                body: bodyWidget(state, context));
          }),
    );
  }

  Widget bodyWidget(ProfileStates state, BuildContext context) {
    if (state is GetProfileDetailsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var profile = ProfileCubit.get(context).userDetails;
      var formKey = GlobalKey<FormState>();
      var emailController = TextEditingController(
        text: profile?.email,
      );
      var phoneController = TextEditingController(
        text: profile?.phone,
      );
      var nameController = TextEditingController(
        text: profile?.name,
      );
      return Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90.h,
                      width: 90.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: (profile == null || profile.photo!.isEmpty)
                                  ? Image.asset(ImagesManger.avatar).image
                                  : Image.network(profile.photo!).image,
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greyLight)),
                      child: GestureDetector(
                        onTap: () async {
                          await ProfileCubit.get(context)
                              .uploadProfileImg(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.greyLight)),
                            child: const Icon(Icons.camera_alt)),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      hint: AppStrings.firstNameHINT,
                      controller: nameController,
                      validateEmptyMSG: AppStrings.firstNameEmptyMSG,
                      type: TextInputType.name,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      hint: AppStrings.emailAddressHINT,
                      controller: emailController,
                      validateEmptyMSG: AppStrings.emailAddressEmptyMSG,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      hint: AppStrings.phoneNumberHINT,
                      controller: phoneController,
                      validateEmptyMSG: AppStrings.phoneNumberEmptyMSG,
                      type: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    AppButtonBlue(
                        text: AppStrings.editAccount,
                        onTap: () async {
                          var newUserDetails = UserDetails(
                              name: nameController.text,
                              photo: profile?.photo ?? "",
                              isVerify: profile?.isVerify ?? false,
                              isPhoneVerify: profile?.isPhoneVerify ?? false,
                              phone: phoneController.text,
                              email: emailController.text,
                              id: profile?.id ?? "",
                              refarCode: profile?.refarCode ?? "");
                          if (profile != newUserDetails) {
                            if (formKey.currentState!.validate()) {
                              await ProfileCubit.get(context)
                                  .updateProfileDetails(newUserDetails);
                            }
                          }
                        }),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () async {
                              ProfileCubit.get(context)
                                  .deleteAccount()
                                  .then((value) {
                                AppToasts.successToast(AppStrings.deleted);
                                Navigator.pushReplacementNamed(
                                    context, AppRouteStrings.home);
                              }).catchError((err) {
                                AppToasts.errorToast(AppStrings.errorInternal);
                              });
                            },
                            child: Text(
                              AppStrings.deleteAccount,
                              style: TextStyle(color: AppColors.red),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
