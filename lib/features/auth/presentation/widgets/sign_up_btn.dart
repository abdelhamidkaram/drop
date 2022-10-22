import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class SignUpBTN extends StatelessWidget {
  final double value ;
  final VoidCallback? onTap ;
  const SignUpBTN({Key? key, required this.value, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        width: 80,
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                color:const Color(0xFFE3E3E3),
                strokeWidth: 5,
                backgroundColor: AppColors.primaryColor,
                value: value,
              ),
            ),
            Center(
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle
                ),
                child:  Icon(value == 0.0 ? Icons.check_rounded : Icons.arrow_forward_rounded , color: AppColors.white, size: value == 0.0 ? 50 : null, ),
              ),
            )
          ],
        ),
      ),
    );
  }
}