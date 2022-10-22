import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
extension MediaqueryValue on BuildContext{
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding  => MediaQuery.of(this).viewPadding.top;
  double get bottomPadding  => MediaQuery.of(this).viewInsets.bottom;
}
extension JsonResponseToString on Response{
  String get jsonResponseToString => jsonDecode(data);
}