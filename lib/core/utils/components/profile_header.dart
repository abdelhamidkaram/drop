import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_text_field.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../toasts.dart';
import 'package:dropeg/injection_container.dart' as di;

class ProfileHeader extends StatefulWidget {
  final bool isProfileScreen;
  final VoidCallback? onTap;

  const ProfileHeader(
      {Key? key,
      this.isProfileScreen = false,
      this.onTap})
      : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create:(context) => di.sl<ProfileCubit>()..getProfileDetails(isRefresh: true) ,
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener:(context, state) =>  di.sl<ProfileCubit>() ,
        builder: (context, state) {
          var phoneController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          return Row(
            children: [
              ImageNetworkWithCached(
                imgUrl:  ProfileCubit.get(context).userDetails?.photo ?? "",
                height: 70,
                width: 70,
                isCircular: true,
                ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ProfileCubit.get(context).userDetails?.name ?? "",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (ProfileCubit.get(context).userDetails?.phone != null &&
                            ProfileCubit.get(context).userDetails!.phone!.isNotEmpty)
                        ? Text(ProfileCubit.get(context).userDetails?.phone ?? "")
                        : InkWell(
                            onTap: () {
                              showBottomSheet(
                                elevation: 15,
                                context: context,
                                builder: (context) => SizedBox(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Form(
                                        key: formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                AppStrings.phoneNumberEmptyMSG,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              CustomTextFormField(
                                                isPhone: true,
                                                controller: phoneController,
                                                validateEmptyMSG: AppStrings
                                                    .phoneNumberEmptyMSG,
                                                type: TextInputType.phone,
                                                hint: AppStrings.phoneNumberHINT,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: AppButtonBlue(
                                                      text: AppStrings.addPhone,
                                                      onTap: () async {
                                                        if (formKey.currentState!
                                                            .validate()) {
                                                          await ProfileCubit.get(
                                                                  context)
                                                              .sendPhone(
                                                                  phoneController
                                                                      .text)
                                                              .then((value) {
                                                            AppToasts
                                                                .successToast(
                                                                    AppStrings
                                                                        .success);
                                                            Navigator.pushNamed(
                                                                context , AppRouteStrings.account);
                                                          }).catchError((err) {
                                                            AppToasts.errorToast(
                                                                AppStrings
                                                                    .errorInternal);
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Expanded(
                                                    child: AppButtonRed(
                                                        text: AppStrings.cancel,
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              AppStrings.addPhone,
                              style: TextStyle(color: AppColors.primaryColor),
                            )),
                  ],
                ),
              ),
              widget.isProfileScreen
                  ? const Icon(Icons.arrow_forward_ios_rounded)
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }
}
