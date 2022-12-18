import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/features/Order/domain/entities/orders.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/screen/my_order/myorder/presentation/cubit/myorder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyorderCubit, MyorderStates>(
      listener: (context, state) => MyorderCubit(),
      builder: (context, state) {
        List<OrderEntity>? orders = [];
        Widget ordersListBuild(List<OrderEntity>? orders) {
          if (state is GetMyorderError) {
            return const Center(
              child: Text(AppStrings.errorInternal),
            );
          } else if (state is GetMyorderloading) {
            return const SafeArea(
                child: Center(
              child: CircularProgressIndicator.adaptive(),
            ));
          } else {
            orders = MyorderCubit.get(context).orders;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    color: AppColors.white,
                    child: orders.isEmpty
                        ? const Center(child: Text(AppStrings.noOrders))
                        : Column(
                            children: List.generate(
                            orders.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouteStrings.confirmOrder,
                                  arguments: ConfirmOrderArgs(
                                    vat: orders![index].vat,
                                    grandTotal:
                                        orders[index].grandTotal.toString(),
                                    order: orders[index],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    Card(
                                      child: SizedBox(
                                          height: 98.h,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(children: [
                                              Expanded(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    orders != null
                                                        ? orders[index]
                                                                    .time
                                                                    .length >
                                                                10
                                                            ? orders[index]
                                                                .time
                                                                .substring(
                                                                    0, 10)
                                                            : orders[index].time
                                                        : "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    orders != null
                                                        ? orders[index]
                                                            .getInfo()
                                                        : "",
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  )
                                                ],
                                              )),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppStrings.egp,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor),
                                                  ),
                                                  Text(
                                                    orders?[index]
                                                            .grandTotal
                                                            .toString() ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor),
                                                  ),
                                                ],
                                              )
                                            ]),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))),
              ],
            );
          }
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CustomAppbars.loginAppbar(
                        context: context,
                        title: AppStrings.myOrders,
                        isMyOrdersScreen: true,
                        height: 233),
                    Column(
                      children: [
                        const SizedBox(height: 180),
                        ordersListBuild(orders),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
