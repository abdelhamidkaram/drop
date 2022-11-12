import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
      child: Container(
        height: 40.h,
        width: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.lightPrimaryColor,
        ),
      ),
    );
  }
}
