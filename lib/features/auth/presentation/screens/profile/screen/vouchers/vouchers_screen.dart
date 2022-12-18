import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/auth/domain/entities/vouchers.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/vouchers/cubit/voucher_cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/vouchers/widgets/ticket_widget.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/hello_there.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoucherCubit>(
      create: (context) => VoucherCubit()..getVouchers(),
      child: BlocConsumer<VoucherCubit, VoucherState>(
        listener: (context, state) => VoucherCubit(),
        builder: (context, state) {
          Widget voucherBodyWidget() {
            if (state is GetVoucherSucsess) {
              List<Color> colors = [AppColors.primaryColor, AppColors.red];
              List<Voucher> vouchers = state.vouchers;
              if (state.vouchers.isEmpty) {
                return const Center(
                  child: Text(AppStrings.noVoucher),
                );
              } else {
                return SizedBox(
                  height: 510.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TicketWidgetBuildItem(
                            colors: colors,
                            vouchers: vouchers,
                            index: index,
                          ),
                          SizedBox(
                            width: 250.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    vouchers[index].title ?? "..",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 22.sp),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 80.h,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        vouchers[index].details ?? "...",
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 6,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "${AppStrings.expires} ${vouchers[index].endDate}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: 8.w,
                    ),
                    itemCount: vouchers.length,
                  ),
                );
              }
            } else if (state is GetVoucherLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const Center(
                child: Text(
                  AppStrings.errorInternal,
                ),
              );
            }
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CustomAppbars.loginAppbar(
                          context: context,
                          title: AppStrings.vouchers,
                          isMyOrdersScreen: true,
                          height: 233),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 25.h , left: 20.h ),
                        child: HelloThere(
                          title:
                              "${AppStrings.hey} ${userInfo?.name},",
                          subtitle: AppStrings.hereAreYourEarnedVouchers,
                        ),
                      ),
                      
                    ],
                  ),
                  voucherBodyWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
