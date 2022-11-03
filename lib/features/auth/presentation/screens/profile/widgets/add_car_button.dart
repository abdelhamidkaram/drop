import 'package:dropeg/config/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_string.dart';
class AddCarButton extends StatelessWidget {
  const AddCarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRouteStrings.addCar , arguments: true);
      },
      child: SizedBox(
        height: 72.h,
        child:  Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                  size: 40.sp ,
                ),
                SizedBox(height: 8.h,),
                Text(AppStrings.addCar , style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppColors.primaryColor
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
