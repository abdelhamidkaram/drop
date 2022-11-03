import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/features/auth/domain/entities/vouchers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../core/utils/components/app_buttons.dart';

class TicketWidgetBuildItem extends StatelessWidget {
  final List<Color> colors;
  final int index;
  final List<Voucher> vouchers;
  const TicketWidgetBuildItem(
      {super.key,
      required this.colors,
      required this.index,
      required this.vouchers});
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
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
                          .headline1!
                          .copyWith(color: AppColors.white),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      vouchers[index].discount ?? "..",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: AppColors.white, fontSize: 60.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppStrings.off,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: AppColors.white, fontSize: 40.sp),
                    ),
                    const Spacer(),
                    AppButtonWhite(
                        text: AppStrings.redeem,
                        onTap: () {
                          // Todo: REDEEM
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
