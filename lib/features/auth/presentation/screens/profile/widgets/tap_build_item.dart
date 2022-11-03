import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/app_colors.dart';

class TapBuildItem extends StatelessWidget {
  const TapBuildItem({
    Key? key,
    required this.context,
    required this.assetSvgIcon,
    required this.text,
     this.onTab
  }) : super(key: key);

  final BuildContext context;
  final String assetSvgIcon;
  final String text;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Column(
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
      ),
    );
  }
}
