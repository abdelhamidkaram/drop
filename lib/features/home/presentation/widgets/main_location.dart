import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/home/presentation/bloc/home_cubit.dart';
import 'package:dropeg/features/home/presentation/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLocation extends StatelessWidget {
  final VoidCallback onTap;
  const MainLocation({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => HomeCubit(),
      listenWhen: (previous, current) => current is GetMainLocationSuccess,
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            final LocationEntity? location =
                HomeCubit.get(context).mainLocation;
            return Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 65.h,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconsManger.locationHome,
                        width: 32.w,
                        height: 32.h,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location?.type ?? "",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              location?.address ?? "",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 24.h,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(50)),
                        child: GestureDetector(
                          onTap: onTap,
                          child: Center(
                            child: Text(
                              AppStrings.change,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
