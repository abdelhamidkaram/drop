import 'package:flutter/material.dart';
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

  const AppButtonBlue({
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
