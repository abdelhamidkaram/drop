import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/auth/domain/entities/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarListItem extends StatefulWidget {
  final Car? car;
  const CarListItem({
    Key? key,
     this.car,
  }) : super(key: key);

  @override
  State<CarListItem> createState() => _CarListItemState();
}

class _CarListItemState extends State<CarListItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = (OrderCubit.get(context).carSelected == widget.car) && OrderCubit.get(context).carSelected != null ;
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) => OrderCubit(),
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            OrderCubit.get(context).changedCarSelected(car: widget.car);
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.shadowPrimaryColor : AppColors.cardBackGround,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 2,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.greyBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.car?.getInfo() ?? "...",
                    maxLines: 2,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  isSelected
                      ? SvgPicture.asset(IconsManger.rightIcon, width: 20.h, height: 20.h,)
                      : Icon(
                          Icons.circle,
                          color: AppColors.white,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
