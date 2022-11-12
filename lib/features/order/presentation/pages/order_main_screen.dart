import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:flutter/material.dart';

class OrderMainScreen extends StatefulWidget {
  final LocationEntity location;
  const OrderMainScreen({super.key, required this.location});

  @override
  State<OrderMainScreen> createState() => _OrderMainScreenState();
}

class _OrderMainScreenState extends State<OrderMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Main Order  >> "),
      ),
    );
  }
}
