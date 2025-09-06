import 'package:car_wash_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class TabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const TabChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryColor
              : AppColors.greyColor.withAlpha(100),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.black12,
          ),
        ),
        child: CustomText(
          text: label,
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}
