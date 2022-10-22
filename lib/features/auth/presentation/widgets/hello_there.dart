import 'package:dropeg/core/utils/app_string.dart';
import 'package:flutter/material.dart';

class HelloThere extends StatelessWidget {
  final String subtitle;
  final String? title;
  const HelloThere({
    Key? key, required this.subtitle,  this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? AppStrings.helloThere,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}