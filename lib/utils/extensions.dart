import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;

  bool get isPhone => MediaQuery.of(this).size.shortestSide < 600;
}