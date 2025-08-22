import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_loader.dart';

class CustomOverLay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomOverLay({super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: (isDarkMode ? Colors.black : AppColors.whiteColor).withOpacity(0.5),
            child: const CustomLoader(),
          ),
      ],
    );
  }
}
