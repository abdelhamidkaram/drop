import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/app_colors.dart';

class TapBuildItem extends StatelessWidget {
  const TapBuildItem({
    Key? key,
    required this.context,
    required this.assetSvgIcon,
    required this.text,
  }) : super(key: key);

  final BuildContext context;
  final String assetSvgIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(assetSvgIcon),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
