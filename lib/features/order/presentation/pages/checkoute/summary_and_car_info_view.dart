import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/order/presentation/widgets/car_item.dart';
import 'package:dropeg/features/order/presentation/widgets/order_summary_widget.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/components/category_title.dart';
import '../../cubit/order_cubit.dart';

class SummaryAndCarInformationView extends StatelessWidget {
  final OrderCubit orderCubit;
  const SummaryAndCarInformationView({super.key, required this.orderCubit});
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CategoryTitle(title: AppStrings.orderSummary),
         SizedBox(
          height: 5.h,
        ),
        OrderSummaryWidget(requiredSelected: orderCubit.requiredSelected),
         SizedBox(
          height: 10.h,
        ),
        const CategoryTitle(title: AppStrings.carInformation),
                SizedBox(height: 5.0.h,),
        BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            return Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: List.generate(
                    ProfileCubit.get(context).cars?.length ?? 0,
                    (index) => CarListItem(
                          car: ProfileCubit.get(context).cars?[index],
                        )),
              ),
            ));
          },
        ),
      ],
    );
  }
}
