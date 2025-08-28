import 'package:flutter/material.dart';
import 'custom_text.dart'; // Make sure to import your CustomText widget

class CustomEmptyView extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final double titleFontSize;
  final double subtitleFontSize;
  final Color titleColor;
  final Color subtitleColor;

  const CustomEmptyView({
    super.key,
    this.title = 'No data found',
    this.subtitle = 'Check back later for updated information',
    this.icon = Icons.info_outline,
    this.iconSize = 48,
    this.iconColor = Colors.grey,
    this.titleFontSize = 16,
    this.subtitleFontSize = 14,
    this.titleColor = Colors.black54,
    this.subtitleColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          const SizedBox(height: 16),
          CustomText(
            text: title,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: subtitle,
            fontSize: subtitleFontSize,
            color: subtitleColor,
          ),
        ],
      ),
    );
  }
}