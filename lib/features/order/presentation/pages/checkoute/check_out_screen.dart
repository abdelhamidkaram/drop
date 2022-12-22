import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/config/route/app_route_arguments.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/order/presentation/pages/checkoute/payment_info_view.dart';
import 'package:dropeg/features/order/presentation/pages/checkoute/promocode_view.dart';
import 'package:dropeg/features/order/presentation/pages/checkoute/summary_and_car_info_view.dart';
import 'package:dropeg/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:dropeg/injection_container.dart' as di;

import '../../../domain/entities/orders.dart';
import '../../widgets/price_box_widget_view.dart';
import 'essential_view.dart';
import 'location_info_view.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getCars();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);
        List vatList = (orderCubit.total * 0.14).toString().split(".");
        double? vat = double.tryParse(
            "${vatList.first}.${vatList.last.toString().substring(0, 1)}");
        var grandTotalList = ((vat! + orderCubit.total) -
                (orderCubit.total * (orderCubit.promoCodeDiscount / 100)))
            .toString()
            .split(".");
        String grandTotal =
            "${grandTotalList.first}.${grandTotalList.last.toString().substring(0, 1)}";
        return Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            children: [
              CustomAppbars.homeAppBar(
                  height: 233, helloTitle: " ", context: context, onTap: null),
              Column(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SummaryAndCarInformationView(
                                orderCubit: orderCubit),
                            SizedBox(
                              height: 15.h,
                            ),
                            LocationInformationView(orderCubit: orderCubit),
                            SizedBox(
                              height: 20.h,
                            ),
                            PaymentMethodInfoView(orderCubit: orderCubit),
                            SizedBox(
                              height: 15.h,
                            ),
                            PromoCodeWidgetView(
                                formKey: formKey, orderCubit: orderCubit),
                            SizedBox(
                              height: 15.h,
                            ),
                            EssentialWidgetView(orderCubit: orderCubit),
                            SizedBox(
                              height: 15.h,
                            ),
                            PriceBoxWidgetView(
                                orderCubit: orderCubit,
                                vat: vat,
                                grandTotal: grandTotal),
                            SizedBox(
                              height: 20.h,
                            ),
                            AppButtonBlue(
                                text: AppStrings.confirmAppointment,
                                onTap: () async {
                                  if (orderCubit.carSelected == null) {
                                    AppToasts.errorToast(
                                        AppStrings.pleaseChooseCar);
                                  } else {
                                    var order = OrderEntity(
                                        status: 1,
                                        requiredServices:
                                            orderCubit.requiredSelected,
                                        car: orderCubit.carSelected!,
                                        essentials:
                                            orderCubit.essentialsSelected,
                                        promoCode: PromoCode(
                                            code: orderCubit
                                                .promoCodeController.text,
                                            discount: orderCubit
                                                .promoCodeDiscount
                                                .toString(),
                                            type: orderCubit.promoCodeType),
                                        location: orderCubit.orderLocation!,
                                        details: "",
                                        id: const Uuid().v4(),
                                        uid: uId,
                                        time: orderCubit.orderDateTime ??
                                            DateTime.now().toString(),
                                        isFinish: false,
                                        price: orderCubit.total.toString(),
                                        grandTotal:
                                            double.tryParse(grandTotal) ??
                                                10000.0,
                                        vat: vat);
                                    await orderCubit
                                        .sendOrderToServer(order: order)
                                        .then((value) {
                                      di
                                          .sl<AppPreferences>()
                                          .setShowOrderTopNotification(true);
                                      Navigator.pushNamed(
                                        context,
                                        AppRouteStrings.confirmOrder,
                                        arguments: ConfirmOrderArgs(
                                          order: order,
                                          grandTotal: grandTotal,
                                          vat: vat,
                                        ),
                                      );
                                    });
                                  }
                                }),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}
