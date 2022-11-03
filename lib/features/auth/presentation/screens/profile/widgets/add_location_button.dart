import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/route/app_route.dart';
import '../../../../../../config/route/app_route_arguments.dart';
import '../../../../../../core/utils/app_colors.dart';

class AddLocationButton extends StatelessWidget {
  const AddLocationButton({
    Key? key,
    required this.profileCubit,
  }) : super(key: key);

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRouteStrings.location ,  arguments: LocationsArgs(formProfileScreen: true));
      },
      child: Row(
        children: [
          SizedBox(
            height: 65.h,
            width: 65.h,
            child: Card(
              color: AppColors.cardBackGround,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                  size: 40.sp ,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Text(
              AppStrings.addLocation,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                color: AppColors.primaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
