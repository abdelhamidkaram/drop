
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/components/img_network_with_cached.dart';
import 'package:dropeg/features/Order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EssentialWidgetView extends StatelessWidget {
  const EssentialWidgetView({
    Key? key,
    required this.orderCubit,
  }) : super(key: key);

  final OrderCubit orderCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const  CategoryTitle(title: AppStrings.essentialAddOns),
       SizedBox(height: 10.h,),
        SizedBox(
            height: 175.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: orderCubit.essentials.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  orderCubit.addOrRemoveEssentialSelected(
                      essential: orderCubit.essentials[index]);
                },
                child: Card(
                  child: Container(
                    width: 140.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 2,
                          color: orderCubit.essentialsSelected
                                  .contains(orderCubit.essentials[index])
                              ? AppColors.primaryColor
                              : AppColors.cardBackGround,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageNetworkWithCached(
                                imgUrl: orderCubit.essentials[index].photo),
                            Text(
                              orderCubit.essentials[index].name,
                              style: Theme.of(context).textTheme.headline3,
                              maxLines: 2,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${AppStrings.egp} ${orderCubit.essentials[index].price}",
                                  style: Theme.of(context).textTheme.headline6!,
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: 10.w,
              ),
            )),
      ],
    );
  }
}
