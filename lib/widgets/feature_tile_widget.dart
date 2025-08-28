import 'package:flutter/material.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_text.dart';

class CustomFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final double iconSize;
  final double tileHeight;
  final bool showCheckmark;

  const CustomFeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color = AppColors.primaryColor,
    this.iconSize = 24,
    this.tileHeight = 80,
    this.showCheckmark = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyColor, width: 1),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.greyColor.withAlpha(100),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: iconSize),
          ),

          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: subtitle,
                  fontSize: 14,
                  color: Colors.grey[600],
                  maxLine: 2,
                ),
              ],
            ),
          ),

          // Checkmark Badge (optional)
          if (showCheckmark) Icon(Icons.check_circle, color: color, size: 20),
        ],
      ),
    );
  }
}
