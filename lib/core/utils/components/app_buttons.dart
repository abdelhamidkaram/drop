import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/route/app_route_arguments.dart';
import '../app_colors.dart';
import '../app_string.dart';

class AppButtonLight extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonLight({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryColor, width: 2),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ),
      ),
    );
  }
}

class AppButtonBlue extends StatelessWidget {
  final String text;

  final VoidCallback onTap;
  final double? height;

  const AppButtonBlue({
    Key? key,
    required this.text,
    required this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 43.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.white,
              ),
        )),
      ),
    );
  }
}

class AppButtonRed extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonRed({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43.h,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.white,
              ),
        )),
      ),
    );
  }
}

class AppButtonWhite extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const AppButtonWhite({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppColors.primaryColor,
              ),
        )),
      ),
    );
  }
}

class AppChangeButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AppChangeButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.18),
          borderRadius: BorderRadius.circular(50)),
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatelessWidget {
  final LocationEntity location;
  final bool isExterior;
  const OrderButton({
    super.key,
    required this.location,
    required this.isExterior,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) => OrderCubit(),
      builder: (context, state) {
        var washNowButton = GestureDetector(
          onTap: () {
            if (OrderCubit.get(context).requiredSelected.isNotEmpty) {
              Navigator.pushNamed(context, AppRouteStrings.checkOut);
            } else {
              AppToasts.errorToast(AppStrings.chooseAtLeastOneServices);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                IconsManger.washNowIcon,
                height: 25.h,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                AppStrings.washNow,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColors.white),
              )
            ],
          ),
        );
        var interiorButton = GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                arguments: OrderMainArgs(
                    locationEntity:
                        OrderCubit.get(context).orderLocation ?? location),
                context,
                AppRouteStrings.interior);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.w,
              ),
              Text(
                AppStrings.interior,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColors.white),
              ),
              SizedBox(
                width: 10.w,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12.h,
                color: AppColors.white,
              )
            ],
          ),
        );
        var totalPrice = Text(
          "${AppStrings.total} ${AppStrings.egp} ${OrderCubit.get(context).total}",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: AppColors.white),
        );
        return Container(
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isExterior ? washNowButton : totalPrice,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  isExterior ? interiorButton : washNowButton,
                ],
              ),
            ));
      },
    );
  }
}
