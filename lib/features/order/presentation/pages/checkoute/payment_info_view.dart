
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/components/category_title.dart';
import '../../cubit/order_cubit.dart';
import '../../widgets/payment_method_item.dart';

class PaymentMethodInfoView extends StatelessWidget {
  const PaymentMethodInfoView({
    Key? key,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoryTitle(title: AppStrings.paymentMethod),
          SizedBox(height: 5.0.h,),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                PaymentMethodItem(
                    paymentMethodType:
                        PaymentMethodType.cash,
                    onTap: () {
                      OrderCubit.get(context)
                          .changePaymentMethod(
                              paymentMethodType:
                                  PaymentMethodType
                                      .cash);
                    },
                    orderCubit: orderCubit),
                    SizedBox(height: 5.0.h,),
                    /// Disable the payment method button
                    // PaymentMethodItem(
                    // paymentMethodType:
                    //     PaymentMethodType.visaCard,
                    // onTap: () {
                    //   OrderCubit.get(context)
                    //       .changePaymentMethod(
                    //           paymentMethodType:
                    //               PaymentMethodType
                    //                   .visaCard);
                    // },
                    // orderCubit: orderCubit),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
