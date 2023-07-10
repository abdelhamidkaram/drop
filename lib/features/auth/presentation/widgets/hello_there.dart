import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';

class HelloThere extends StatelessWidget {
  final String subtitle;
  final String? title;
  final TextStyle?  style;
  const HelloThere({
    Key? key, required this.subtitle,  this.title, this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? AppStrings.helloThere,
          style: style != null ? style : (title == AppStrings.pleaseSelectedService ? Theme.of(context).textTheme.displayMedium!.copyWith(
            fontFamily: AppStrings.fontFamily_2_rubik,
            fontWeight: FontWeight.w600,
          )  :  Theme.of(context).textTheme.displayMedium),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColors.subTitleColor,
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}