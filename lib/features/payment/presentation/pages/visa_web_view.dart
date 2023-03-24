import 'package:dropeg/core/utils/components/web_view.dart';
import 'package:flutter/material.dart';

class VisaCardScreen extends StatefulWidget {
  const VisaCardScreen({Key? key}) : super(key: key);

  @override
  State<VisaCardScreen> createState() => _VisaCardScreenState();
}

class _VisaCardScreenState extends State<VisaCardScreen> {
  @override
  Widget build(BuildContext context) {
    return const BrowserScreen(url: "url");
  }
}
