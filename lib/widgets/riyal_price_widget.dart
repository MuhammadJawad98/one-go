import 'package:flutter/material.dart';

import '../utils/app_assets.dart';

class RiyalPriceWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  const RiyalPriceWidget({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.saudiRiyal,width: 15,height: 15, color: color),
          const SizedBox(width: 5),
          child,
        ],
      ),
    );
  }
}
