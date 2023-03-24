import 'package:dio/dio.dart';
import 'package:dropeg/features/payment/models/auth_token.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context)=>BlocProvider.of(context);

  String? firstToken = '';
  int? orderId;
  String? finalToken;

  Future getAuthToken() async {
    emit(PaymentAuthTokenLoading());
     try {
       var response =  await Dio().post('https://accept.paymobsolutions.com/api/auth/tokens' , data: {
         "api_key": "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam8wTWpFMExDSmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aWZRLlRKOWttUzZJbnlYTTFtb3VkZzhIYVQ3eEIyZk5LZFVFcDE4dG1EVk05VDlFM2UyZU8tSEQwRGtHRkIzeFh1RUtmYUpiSWEzcWVCcjhabktiT282N2pR"
       });
       firstToken = PaymentAuthToken.fromJson(response.data).token;
       emit(PaymentAuthTokenSuccess());

     } on Exception catch (e) {
       debugPrint(e.toString());
       emit(PaymentAuthTokenError(error: e.toString()));
     }
  }

  Future getOrderId({required String price})async {

    await getAuthToken().then((value) async {
      emit(PaymentGetOrderIdLoading());
      try {
        var res = await Dio().post(
            "https://accept.paymobsolutions.com/api/ecommerce/orders" ,
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
                  'Content-Type':'application/json'
                }
            )
        );
        orderId = res.data['id'];
        debugPrint("///////////////// order id :   //////////////////\n"+orderId.toString());
        emit(PaymentGetOrderIdSuccess());
      } on Exception catch (e) {
        debugPrint(e.toString());
        emit(PaymentGetOrderIdError(error: e.toString()));
      }

    } );

 
  }


  Future getFinalToken({ required String price , required String firstName ,required String lastName ,required String email , required String phone })async{
    getOrderId(price: price).then((value) async {
      emit(PaymentGetFinalTokenCardLoading());
      try {
        var res = await Dio().post(
            "https://accept.paymobsolutions.com/api/acceptance/payment_keys" ,
            data:
            {
              "auth_token": firstToken,
              "amount_cents": price,
              "expiration": 3600,
              "order_id": orderId.toString(),
              "billing_data": {
                "apartment": "NA",
                "email": email,
                "floor": "NA",
                "first_name": firstName,
                "street": "NA",
                "building": "NA",
                "phone_number": phone,
                "shipping_method": "NA",
                "postal_code": "NA",
                "city": "NA",
                "country": "NA",
                "last_name": lastName,
                "state": "NA"
              },
              "currency": "EGP",
              "integration_id": 6741,
              "lock_order_when_paid": "false"
            },
            options: Options(
                headers: {
                  'Content-Type':'application/json'
                }
            )
        );
        finalToken = res.data['token'];
        debugPrint("///////////////// finalToken:   //////////////////\n"+finalToken.toString());
        emit(PaymentGetFinalTokenCardSuccess());
      } on Exception catch (e) {
        debugPrint(e.toString());
        emit(PaymentGetFinalTokenCardError(error: e.toString()));
      }
    });
  }





}