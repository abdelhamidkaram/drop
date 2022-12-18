import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/Order/domain/entities/orders.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceBoxWidgetView extends StatelessWidget {
  const PriceBoxWidgetView({
    Key? key,
    required this.orderCubit,
    this.order,
    required this.vat,
    required this.grandTotal,
  }) : super(key: key);

  final OrderCubit orderCubit;
  final OrderEntity? order;
  final double? vat;
  final String grandTotal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(AppStrings.subtotal),
                  const Spacer(),
                  Text("${AppStrings.egp} ${order?.price ?? orderCubit.total}"),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              orderCubit.promoCodeDiscount != 0
                  ? Column(
                      children: [
                        Row(
                          children: [
                            const Text(AppStrings.discount),
                            const Spacer(),
                            Text(
                                "${AppStrings.egp} - ${orderCubit.total * (orderCubit.promoCodeDiscount / 100)}"),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )
                  : const SizedBox(),
              Row(
                children: [
                  const Text(AppStrings.vat14),
                  const Spacer(),
                  Text("${AppStrings.egp} $vat"),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(color: AppColors.grey, height: 2),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Text(AppStrings.grandTotal),
                  const Spacer(),
                  Text(
                    grandTotal,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
