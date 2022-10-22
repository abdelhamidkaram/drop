import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class AppSocialButton extends StatelessWidget {
  final String text ;
  final Color color ;
  final IconData ? icon ;
  final VoidCallback onTap ;

  const AppSocialButton({
    Key? key, required this.text, required this.color,  this.icon, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.white,
                size: 40,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(
                      color: AppColors.white))
            ],
          ),
        ),
      ),
    );
  }
}
