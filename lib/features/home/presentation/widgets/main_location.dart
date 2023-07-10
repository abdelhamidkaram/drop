import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/location_icon.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/home/bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropeg/injection_container.dart' as di;

class MainLocation extends StatelessWidget {
  final VoidCallback onTap;
  const MainLocation({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) => di.sl<HomeCubit>(),
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
                        locationIcon(location?.type ?? "Home"),
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
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "${location?.addressForView ?? "" }",
                              maxLines: 2,
                              style: const TextStyle(
                                 height: 0.99,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      AppChangeButton(onTap:onTap ,  text: AppStrings.change),
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
