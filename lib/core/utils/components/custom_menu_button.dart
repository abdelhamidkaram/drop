import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
class CustomMenuButton extends StatefulWidget {
  final VoidCallback onTap;
  const CustomMenuButton({Key? key, required this.onTap}) : super(key: key);
  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: SvgPicture.asset(
            IconsManger.menuIcon ,
            color: AppColors.lightPrimaryColor,
            width: 10,
            height: 10,
          ),
        ),
      ),
    );
  }
}
