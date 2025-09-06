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
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(child: CustomButton(text: text, onPressed: onTap)),
    );
  }
}
