import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final bool isProfileScreen;

  const ProfileHeader({Key? key, this.isProfileScreen = false})
      : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset(ImagesManger.avatar).image,
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
          border: Border.all(color: AppColors.greyLight)
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Youssef Elhossary",
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("+20 0103 32 328 03 "),
            ],
          ),
        ),
        widget.isProfileScreen
            ? const Icon(Icons.arrow_forward_ios_rounded)
            : const SizedBox()
      ],
    );
  }
}
