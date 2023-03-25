import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/components/app_buttons.dart';
import 'package:dropeg/features/payment/presentation/bloc/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCallBackScreen extends StatefulWidget {
  final bool paymentSuccessAndSendOrderToServerNotSuccess;
  const PaymentCallBackScreen({Key? key , this.paymentSuccessAndSendOrderToServerNotSuccess = false}) : super(key: key);

  @override
  State<PaymentCallBackScreen> createState() => _PaymentCallBackScreenState();
}

class _PaymentCallBackScreenState extends State<PaymentCallBackScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) =>PaymentCubit(),
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child:(state is PaymentCallBackSuccess)
                    ? Text( widget.paymentSuccessAndSendOrderToServerNotSuccess ? "Your payment was successful, but your request was not completed, please contact support": "success" )
                    : Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning_rounded , size: 100,color: AppColors.red),
                        Text("An error occurred during the payment process , Please verify your payment information and try again later" , textAlign: TextAlign.center),
                        SizedBox(height: 16.0,),
                        AppButtonBlue(text: "Home", onTap: (){
                          Navigator.pushReplacementNamed(context, AppRouteStrings.home);
                        }),
                      ],

                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
