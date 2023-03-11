import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/category_title.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/confirm%20order/presentation/cubit/confirm_order_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../order/domain/entities/orders.dart';
import '../../../order/presentation/cubit/order_cubit.dart';
import '../../../order/presentation/widgets/price_box_widget_view.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final OrderEntity order;
  final double vat;
  final String grandTotal;

  const ConfirmOrderScreen({
    super.key,
    required this.order,
    required this.vat,
    required this.grandTotal,
  });

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future changeOrderStatusInUserCollections(
        {required OrderEntity order,
        required bool isFinish,
        required int status}) async {
      if (isFinish == order.isFinish && status == order.status) {
        return;
      } else {
        try {
          await FirebaseFirestore.instance
              .collection(FirebaseStrings.usersCollection)
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection(FirebaseStrings.ordersCollection)
              .doc(order.id)
              .update({"status": status, "isFinish": isFinish});
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, AppRouteStrings.home);
        return Future.value(true);
      },
      child: Builder(
        builder: (context) {
          FirebaseFirestore.instance
              .collection(FirebaseStrings.ordersCollection)
              .doc(widget.order.id)
              .snapshots()
              .listen((event) {
            if (event.data()?["status"] == 1) {
              setState(() {
                ConfirmOrderCubit.get(context).orderStatus =
                    OrderStatus.onTheWay;
                changeOrderStatusInUserCollections(
                        isFinish: false, order: widget.order, status: 1)
                    .then((value) => null);
              });
            } else if (event.data()?["status"] == 2) {
              setState(() {
                ConfirmOrderCubit.get(context).orderStatus =
                    OrderStatus.onProgress;
                changeOrderStatusInUserCollections(
                        isFinish: false, order: widget.order, status: 2)
                    .then((value) => null);
              });
            } else if (event.data()?["status"] == 3) {
              setState(() {
                ConfirmOrderCubit.get(context).orderStatus = OrderStatus.done;
                changeOrderStatusInUserCollections(
                        isFinish: true, order: widget.order, status: 3)
                    .then((value) => null);
              });
            } else if (event.data()?["status"] == 4) {
               ConfirmOrderCubit.get(context).orderStatus = OrderStatus.cancel;
                changeOrderStatusInUserCollections(
                        isFinish: false, order: widget.order, status: 4)
                    .then((value) => null);
            }
          });
          return BlocBuilder<ConfirmOrderCubit, ConfirmOrderState>(
            builder: (context, state) {
              var cubit = ConfirmOrderCubit.get(context);
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 13.h,
                            ),
                            Center(
                              child: Text(
                                AppStrings.orderConfirmed,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            OrderStatusTextView(cubit: cubit),
                            LottieBuilder.asset(cubit.jsonAsset()),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  OrderConfirmIconsView(cubit: cubit),
                                  PriceBoxWidgetView(
                                      order: widget.order,
                                      orderCubit: OrderCubit.get(context),
                                      vat: widget.vat,
                                      grandTotal:
                                          widget.order.grandTotal.toString()),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  OrderedServicesView(order: widget.order),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  OrderConfirmButtonsView(
                                    cubit: cubit,
                                    order: widget.order,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderStatusTextView extends StatelessWidget {
  const OrderStatusTextView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ConfirmOrderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.yourWashDropIs,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            cubit.title(),
            style:
                Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class OrderedServicesView extends StatelessWidget {
  const OrderedServicesView({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CategoryTitle(title: AppStrings.orderedServices),
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                order.requiredServices.length,
                    (index) =>  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(order.requiredServices[index].name),
                    )),
          ),
        ],
      ),
    );
  }
}

class OrderConfirmButtonsView extends StatelessWidget {
  final OrderEntity order;
  const OrderConfirmButtonsView({
    Key? key,
    required this.cubit,
    required this.order,
  }) : super(key: key);

  final ConfirmOrderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButtonBlue(
            text: AppStrings.home,
            onTap: () {
              Navigator.pushNamed(context, AppRouteStrings.home);
            }),
        SizedBox(
          height: 10.h,
        ),
        cubit.orderStatus == OrderStatus.onTheWay
            ? AppButtonRed(
                text: AppStrings.cancelOrder,
                onTap: () {
                  AppToasts.loadingToast();
                  cubit.cancelOrder(order: order).then((value) {
                   
                    AppToasts.successToast(AppStrings.cancelOrder);
                    Navigator.pushReplacementNamed(
                        context, AppRouteStrings.home);
                  });
                })
            : const SizedBox(),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}

class OrderConfirmIconsView extends StatelessWidget {
  const OrderConfirmIconsView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final ConfirmOrderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 20),
      child: SizedBox(
          height: 60.h,
          width: double.infinity,
          child: Row(

            children: [
              Card(
                  child: Container(
                height: 59.h,
                width: 59.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 1.5,
                      color: cubit.orderStatus == OrderStatus.onTheWay
                          ? AppColors.primaryColor
                          : AppColors.cardBackGround),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SvgPicture.asset(
                    IconsManger.orderOnWay,
                    height: 32.h,
                    width: 32.h,
                  ),
                ),
              )),
              Expanded(
                child: Stack(children: [
                  Center(
                    child: Divider(height: 4, color: AppColors.greyBorder),
                  ),
                  Center(
                    child: Card(
                        child: Container(
                          height: 59.h,
                          width: 59.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: cubit.orderStatus == OrderStatus.onProgress
                                ? AppColors.primaryColor
                                : AppColors.cardBackGround),
                      ),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.h,),
                          SvgPicture.asset(
                            IconsManger.orderProgress,
                            height: 38.h,
                            width: 38.h,
                          ),
                        ],
                      ),
                    )),
                  ),
                ]),
              ),
              Card(
                  child: Container(
                height: 59.h,
                width: 59.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 1.5,
                      color: cubit.orderStatus == OrderStatus.done
                          ? AppColors.primaryColor
                          : cubit.orderStatus == OrderStatus.cancel
                              ? AppColors.red
                              : AppColors.cardBackGround),
                ),
                child: Icon(
                  cubit.orderStatus == OrderStatus.cancel
                      ? Icons.close_rounded
                      : Icons.check_circle_sharp,
                  size: 25.h,
                  color: AppColors.primaryColor,
                ),
              ))
            ],
          )),
    );
  }
}
