import 'package:car_wash_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSocialIconWidget extends StatelessWidget {
  final String image;
  final VoidCallback onTap;
  const CustomSocialIconWidget({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGreyTextColor),
          shape: BoxShape.circle
        ),
        child: Image.asset(image,width: 24,height: 24),
      ),
    );
  }
}
