import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/domain/entities/vouchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../core/utils/components/app_buttons.dart';
import '../../../../../../../order/presentation/cubit/order_cubit.dart';
import 'package:flutter_svg/svg.dart';


class TicketWidgetBuildItem extends StatelessWidget {
  final List<Color> colors;
  final int index;
  final List<Voucher> vouchers;
  final LocationEntity? location ;

  const TicketWidgetBuildItem(
      {super.key,
      required this.colors,
      required this.index,
      required this.vouchers , this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 330.h,
          width: 250.w,
          child: Stack(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 330.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          color: colors[index % 2],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 230.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: AppColors.white, shape: BoxShape.circle),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 200.w,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    184.w ~/ 7.w,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1.0),
                                          child: Container(
                                            width: 5.w,
                                            height: 1.h,
                                            color: AppColors.white,
                                          ),
                                        )),
                              ),
                            ),
                          )),
                          Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                color: AppColors.white, shape: BoxShape.circle),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      vouchers[index].title ?? "..",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.white),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      vouchers[index].discount ?? "..",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.white, fontSize: 60.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppStrings.off,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.white, fontSize: 40.sp),
                    ),
                    const Spacer(),
                    AppButtonWhite(
                        text: AppStrings.redeem,
                        onTap: () {
                          OrderCubit.get(context).promoCodeDiscount =
                              int.tryParse(vouchers[index]
                                      .discount!
                                      .split("%")
                                      .first
                                      .toString()) ??
                                  1;
                          OrderCubit.get(context).promoCodeController.text =
                              vouchers[index].code!.split("%").first;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 2)),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        SvgPicture.asset(
                                          IconsManger.vouchers,
                                          width: 40.h,
                                          height: 40.h,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Divider(
                                          color: AppColors.black,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          AppStrings.voucherRedeemed,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'You’ll get ${vouchers[index].discount!} off your next order.',
                                        ),
                                        SizedBox(
                                          height: 32,
                                        ),
                                        AppButtonBlue(
                                            text: AppStrings.done,
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  AppRouteStrings.order,
                                                  arguments: OrderMainArgs(
                                                      locationEntity:
                                                          location ??
                                                              LocationEntity(
                                                                address:
                                                                    "address",
                                                                state: "state",
                                                                city: "city",
                                                                type: "Home",
                                                                id: "id",
                                                              )));
                                            }),
                                        SizedBox(
                                          height: 32,
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          );
                        }),
                    SizedBox(
                      height: 10.0.h,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
