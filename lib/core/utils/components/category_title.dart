import 'package:flutter/material.dart';

class CategoryTitle extends StatelessWidget {
  final String title ;
  const CategoryTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .headline3,
        ),
        const Spacer()
      ],
    );
  }
}
