import 'package:dropeg/core/utils/components/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../order/domain/entities/orders.dart';

class VisaCardScreen extends StatefulWidget {
  final String finalToken;
  final OrderEntity order;
  final String grandTotal;
  final double vat;
  const VisaCardScreen({Key? key, required this.finalToken, required this.order, required this.grandTotal, required this.vat}) : super(key: key);

  @override
  State<VisaCardScreen> createState() => _VisaCardScreenState();
}

class _VisaCardScreenState extends State<VisaCardScreen> {
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return  BrowserScreen(
        url: "https://accept.paymob.com/api/acceptance/iframes/746023?payment_token=${widget.finalToken}",
        order: widget.order,
        grandTotal: widget.grandTotal ,
        vat: widget.vat,
    );
  }



}
