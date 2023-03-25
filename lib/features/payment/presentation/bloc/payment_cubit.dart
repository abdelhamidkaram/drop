import 'package:dio/dio.dart';
import 'package:dropeg/features/order/domain/entities/orders.dart';
import 'package:dropeg/features/order/presentation/cubit/order_cubit.dart';
import 'package:dropeg/features/payment/models/auth_token.dart';
import 'package:dropeg/features/payment/presentation/pages/payment_callback_screen.dart';
import 'package:dropeg/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/route/app_route.dart';
import '../../../../config/route/app_route_arguments.dart';
import '../../../../core/shared_prefs/app_prefs.dart';
import '../../../../core/utils/toasts.dart';
import '../pages/visa_web_view.dart';
import 'package:dropeg/injection_container.dart' as di;
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

  String? firstToken = '';
  int? orderId;
  String? finalToken;

  Future _getAuthToken() async {
    emit(PaymentAuthTokenLoading());
    try {
      var response = await Dio().post(
          'https://accept.paymob.com/api/auth/tokens', data: {
        "api_key": "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam8zTWpneU56QXNJbTVoYldVaU9pSnBibWwwYVdGc0lpd2lZMnhoYzNNaU9pSk5aWEpqYUdGdWRDSjkuRktFczVpM0JGb1FTcllSTlJ6NE9yNFFPSDBSSmtBU0dyX1hIbmM5S3ctT0FWa25FVURoTU1RUnRSWTFwY1U5SFZUdW5ZWDBzNlZtaEpTUzl6dHZhbXc="
      });
      firstToken = PaymentAuthToken
          .fromJson(response.data)
          .token;
      emit(PaymentAuthTokenSuccess());
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(PaymentAuthTokenError(error: e.toString()));
    }
  }

  Future _getOrderId({required String price}) async {
    await _getAuthToken().then((value) async {
      emit(PaymentGetOrderIdLoading());
      try {
        var res = await Dio().post(
            "https://accept.paymob.com/api/ecommerce/orders",
            data:
            {
              "auth_token": firstToken,
              "delivery_needed": "false",
              "amount_cents": price,
              "currency": "EGP",
              "items": []
            },

            options: Options(
                headers: {
                  'Content-Type': 'application/json'
                }
            )
        );
        orderId = res.data['id'];
        debugPrint("///////////////// order id :   //////////////////\n" +
            orderId.toString());
        emit(PaymentGetOrderIdSuccess());
      } on Exception catch (e) {
        debugPrint(e.toString());
        emit(PaymentGetOrderIdError(error: e.toString()));
      }
    });
  }


  Future<String?> getFinalToken(BuildContext context,
      { required String price,
        required OrderEntity order,
        required String firstName,
        required String lastName,
        required String email,
        required String phone ,
        required double vat ,
      }) async {
    _getOrderId(price: price).then((value) async {
      emit(PaymentGetFinalTokenCardLoading());
      try {
        var res = await Dio().post(
            "https://accept.paymob.com/api/acceptance/payment_keys",
            data:
            {
              "auth_token": firstToken,
              "amount_cents":price,
              "expiration": 3600,
              "order_id": orderId.toString(),
              "billing_data": {
                "apartment": "NA",
                "email": userInfo?.email!,
                "floor": "NA",
                "first_name": userInfo?.nameForView.split(" ").first??"UNKNOWN",
                "street": "NA",
                "building": "NA",
                "phone_number": userInfo?.phone ?? "01012345678" ,
                "shipping_method": "NA",
                "postal_code": "NA",
                "city": "NA",
                "country": "NA",
                "last_name": userInfo?.nameForView.split(" ").last ?? "UNKNOWN",
                "state": "NA"
              },
              "currency": "EGP",
              "integration_id": 3692084,
              "lock_order_when_paid": "false"
            },
            options: Options(
                headers: {
                  'Content-Type': 'application/json'
                }
            )
        );
        finalToken = res.data['token'];
        debugPrint("///////////////// finalToken: //////////////////\n" +
            res.data['token']);
        emit(PaymentGetFinalTokenCardSuccess());

        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              VisaCardScreen(
                vat: vat,
                grandTotal: order.grandTotal.toString(),

                finalToken: res.data['token'], order: order,),));
        return res.data['token'];
      } on Exception catch (e) {
        debugPrint(e.toString());
        emit(PaymentGetFinalTokenCardError(error: e.toString()));
      }
    });

    return finalToken;
  }

  Future<void> paymentCallBack(
      {required String? value, required String grandTotal, required double vat, required BuildContext context, required OrderEntity order }) async {
    emit(PaymentCallBackLoading());

    if (value != null && value.startsWith(
        "https://accept.paymobsolutions.com/api/acceptance/post_pay?")) {
      if (value.contains("success=true")) {
        await OrderCubit.get(context)
            .sendOrderToServer(order: order)
            .then((value) {
          di.sl<AppPreferences>()
              .setShowOrderTopNotification(
              true);
          Navigator.pushReplacementNamed(
            context,
            AppRouteStrings.confirmOrder,
            arguments: ConfirmOrderArgs(
              order: order,
              grandTotal: grandTotal,
              vat: vat,
            ),
          );
          return ;
        }).catchError((err) {
          debugPrint(err.toString());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaymentCallBackScreen(
                    paymentSuccessAndSendOrderToServerNotSuccess: true,
                  ),
            ),
          );
        });
        emit(PaymentCallBackSuccess());

      }
      if (value.contains("success=false")) {
        AppToasts.errorToast("error");
        emit(PaymentCallBackError());
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => PaymentCallBackScreen(),));

      }
    }


  }


}