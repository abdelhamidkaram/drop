import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/core/utils/components/custom_appbar.dart';
import 'package:dropeg/core/utils/enums.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/home/bloc/home_cubit.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/order/presentation/pages/checkoute/summary_and_car_info_view.dart';
import 'package:dropeg/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:dropeg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../../config/route/app_route.dart';
import '../../../../../config/route/app_route_arguments.dart';
import '../../../../../core/shared_prefs/app_prefs.dart';
import '../../../domain/entities/orders.dart';
import '../../widgets/price_box_widget_view.dart';
import 'location_info_view.dart';
import 'package:dropeg/injection_container.dart' as di;

class FreeOrderScreen extends StatefulWidget {
  const FreeOrderScreen({super.key});

  @override
  State<FreeOrderScreen> createState() => _FreeOrderScreenState();
}

class _FreeOrderScreenState extends State<FreeOrderScreen> {
  var formKey = GlobalKey<FormState>();
  bool btnLoad =false ;
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getCars();
    OrderCubit.get(context).orderLocation = HomeCubit.get(context).mainLocation;}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var orderCubit = OrderCubit.get(context);
        double? vat = 0.0;
        String grandTotal =
            "0.0";
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
                                  isFreeOrder: true,
                                    orderCubit: orderCubit),
                                SizedBox(
                                  height: 15.h,
                                ),
                                LocationInformationView(orderCubit: orderCubit),
                                SizedBox(
                                  height: 20.h,
                                ),

                                PriceBoxWidgetView(
                                    orderCubit: orderCubit,
                                    vat: vat,
                                    grandTotal: grandTotal),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BlocBuilder<PaymentCubit, PaymentState>(
                                  builder: (context, state) {
                                    return AppButtonBlue(
                                        text: AppStrings.confirmAppointment,
                                        onTap: () async {
                                          if (orderCubit.carSelected == null) {
                                            AppToasts.errorToast(
                                                AppStrings.pleaseChooseCar);
                                          } else {
                                            var order = OrderEntity(
                                                isFree: true,
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
                                            if (orderCubit.paymentMethodType ==
                                                PaymentMethodType.visaCard) {
                                              AppToasts.loadingToast();
                                              PaymentCubit.get(context)
                                                  .getFinalToken(context,
                                                  vat: vat,
                                                  order: order,
                                                  price:(order.grandTotal* 100).toStringAsFixed(0),
                                                  firstName: userInfo!.name!,
                                                  lastName: userInfo!.name
                                                      ?.split(" ")
                                                      .last ??
                                                      "unknown",
                                                  email: userInfo!.email!,
                                                  phone: userInfo?.phone ??
                                                      '01012345678')
                                                  .then((value) {
                                                setState(() {
                                                  btnLoad = false ;
                                                });
                                              })
                                                  .catchError((err) {
                                                setState(() {
                                                  btnLoad = false ;
                                                });
                                                debugPrint(err.toString());
                                                AppToasts.errorToast(
                                                    "Payment error , Please try later ");
                                              });
                                            }
                                            if (orderCubit.paymentMethodType ==
                                                PaymentMethodType.cash) {
                                              AppToasts.loadingToast();
                                              await OrderCubit.get(context)
                                                  .sendOrderToServer(order: order)
                                                  .then((value) {
                                                di
                                                    .sl<AppPreferences>()
                                                    .setShowOrderTopNotification(
                                                    true).then((value){
                                                      FirebaseFirestore.instance.collection(FirebaseStrings.usersCollection)
                                                          .doc(FirebaseAuth.instance.currentUser?.uid?? uId)
                                                          .update(
                                                        {
                                                          FirebaseStrings.freeWashUsedField : 0
                                                        }
                                                      ).then((value) => ProfileCubit.get(context).getProfileDetails(firstbuild: true,isRefresh: true));
                                                });
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  AppRouteStrings.confirmOrder,
                                                  arguments: ConfirmOrderArgs(
                                                    order: order,
                                                    grandTotal: grandTotal,
                                                    vat: vat,
                                                  ),
                                                );
                                              }).catchError((err){
                                                debugPrint(err.toString());
                                                AppToasts.errorToast(AppStrings.errorInternal);
                                              });
                                            }
                                          }
                                        });
                                  },
                                ),
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
