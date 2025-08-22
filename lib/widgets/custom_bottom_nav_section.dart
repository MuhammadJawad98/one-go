import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_button.dart';

class CustomBottomNavSection extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomBottomNavSection({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: AppColors.whiteColor,
        border: Border.all(width: 0.5, color: AppColors.lightGreyTextColor),
      ),
      child: CustomButton(text: text, onPressed: onTap),
    );
  }
}
