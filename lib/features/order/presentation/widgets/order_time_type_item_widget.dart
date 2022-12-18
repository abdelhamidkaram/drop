import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTimeTypeWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final OrderTimeType? orderTimeType;
  const OrderTimeTypeWidget({
    Key? key,
    required this.orderTimeType,
    required this.onTap,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 50.h,
        decoration: BoxDecoration(
          color: orderCubit.orderTimeType == orderTimeType ? AppColors.shadowPrimaryColor : AppColors.cardBackGround,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              width: 2,
              color: orderCubit.orderTimeType == orderTimeType
                  ? AppColors.primaryColor
                  : AppColors.greyBorder),
        ),
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: [
                SvgPicture.asset(orderTimeType == OrderTimeType.schedule
                    ? IconsManger.schedule
                    : IconsManger.rightNow),
                SizedBox(
                  width: 16.w,
                ),
                Text(orderTimeType == OrderTimeType.rightNow
                    ? AppStrings.rightNow
                    : AppStrings.scheduleForLater),
              ],
            )),
            orderCubit.orderTimeType == orderTimeType
                ? SvgPicture.asset(IconsManger.rightIcon, width: 20.h, height: 20.h,)
                : Icon(
                    Icons.circle,
                    color: AppColors.white,
                  ),
          ],
        ),
      ),
    );
  }
}
