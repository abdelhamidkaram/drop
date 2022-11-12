import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class AppButtonLight extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonLight({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryColor, width: 2),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}

class AppButtonBlue extends StatelessWidget {
  final String text;

  final VoidCallback onTap;
  final double? height;

  const AppButtonBlue({
    Key? key,
    required this.text,
    required this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 43.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.white,
              ),
        )),
      ),
    );
  }
}

class AppButtonRed extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonRed({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.white,
              ),
        )),
      ),
    );
  }
}

class AppButtonWhite extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonWhite({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.primaryColor,
              ),
        )),
      ),
    );
  }
}

class AppChangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AppChangeButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.18),
          borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
