
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeWidgetView extends StatefulWidget {
  const PromoCodeWidgetView({
    Key? key,
    required this.formKey,
    required this.orderCubit,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final OrderCubit orderCubit;

  @override
  State<PromoCodeWidgetView> createState() => _PromoCodeWidgetViewState();
}

class _PromoCodeWidgetViewState extends State<PromoCodeWidgetView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) => OrderCubit(),
      builder: (context, state) {
        return Column(
          children: [
            const CategoryTitle(title: AppStrings.promoCode),
            Card(
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.greyBorder, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: widget.orderCubit.promoCodeController,
                            decoration: InputDecoration(
                              suffixIcon: SizedBox(
                                  width: 70.w,
                                  child: Center(child: applyButton(state)),
                                ),
                                border: InputBorder.none,
                                hintText: AppStrings.promoCodeHint),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget applyButton(state) {
    if (state is GetPromoCodeLoading) {
      return const LinearProgressIndicator();
    }
    if (state is GetPromoCodeSuccess) {
      return Icon(
        Icons.check_circle,
        color: AppColors.primaryColor,
      );
    }
    return AppChangeButton(
        text: AppStrings.apply,
        onTap: () async {
          if (widget.orderCubit.promoCodeController.text.isNotEmpty) {
            bool isValid = await widget.orderCubit
                .getPromoCode(widget.orderCubit.promoCodeController.text);
            if (isValid) {
              setState(() {
                isValid = true;
              });
            } else {
              setState(() {
                isValid = false;
              });
            }
          }
        });
  }
}
