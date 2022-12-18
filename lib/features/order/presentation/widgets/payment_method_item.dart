import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethodItem extends StatelessWidget {
  final VoidCallback? onTap;
  final PaymentMethodType? paymentMethodType;
  const PaymentMethodItem({
    Key? key,
    required this.paymentMethodType,
    required this.onTap,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 50.h,
          decoration: BoxDecoration(
            color: orderCubit.paymentMethodType == paymentMethodType ? AppColors.shadowPrimaryColor : AppColors.cardBackGround,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 2,
                color: orderCubit.paymentMethodType == paymentMethodType
                    ? AppColors.primaryColor
                    : AppColors.greyBorder),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  SvgPicture.asset( paymentMethodType == PaymentMethodType.cash 
                  ? IconsManger.cashOnDelivery
                  : IconsManger.visa , 
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(paymentMethodType ==  PaymentMethodType.visaCard
                      ? AppStrings.payWithVisa
                      : AppStrings.cashOnDelivery),
                ],
              )),
              orderCubit.paymentMethodType == paymentMethodType
                  ? SvgPicture.asset(IconsManger.rightIcon , width: 20.h, height: 20.h,)
                  : Icon(
                      Icons.circle,
                      color: AppColors.white,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
