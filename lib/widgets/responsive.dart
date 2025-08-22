import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1100 &&
      MediaQuery.sizeOf(context).width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  static Size getDynamicSize(BuildContext context) {
    if (MediaQuery.sizeOf(context).width < 650) {
      return MediaQuery.sizeOf(context);
    } else if(MediaQuery.sizeOf(context).width < 1100 && MediaQuery.sizeOf(context).width >= 650) {
      return MediaQuery.sizeOf(context) / 2;
    }else{
      return MediaQuery.sizeOf(context) / 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
