import 'dart:convert';
import 'package:dropeg/core/api/dio_consumer.dart';
import 'package:dropeg/core/api/end_points.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final DioConsumer dioConsumer ;
  PaymentCubit({required this.dioConsumer}) : super(PaymentInitial());

  static PaymentCubit get(context)=>BlocProvider.of(context);


  Future getAuthToken() async {
    emit(PaymentAuthTokenLoading());
     try {
       var response =  jsonDecode(await dioConsumer.postData(EndPoints.paymentAuthToken , body: {
         "api_key": "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SndjbTltYVd4bFgzQnJJam8wTWpFMExDSmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2libUZ0WlNJNkltbHVhWFJwWVd3aWZRLlRKOWttUzZJbnlYTTFtb3VkZzhIYVQ3eEIyZk5LZFVFcDE4dG1EVk05VDlFM2UyZU8tSEQwRGtHRkIzeFh1RUtmYUpiSWEzcWVCcjhabktiT282N2pR"
       }));
       print(response.toString());
       emit(PaymentAuthTokenSuccess());

     } on Exception catch (e) {
       print(e.toString());
       emit(PaymentAuthTokenError(error: e.toString()));
     }
  }



}