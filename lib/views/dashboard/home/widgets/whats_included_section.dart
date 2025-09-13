import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class WhatsIncludedSection extends StatelessWidget {
  const WhatsIncludedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CustomText(
                text: "What's included",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor, // navy-like color
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(
                    Icons.verified_user,
                    size: 16,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: "SAFE GO",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Features Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _FeatureItem(
                icon: Icons.verified_user,
                title: "Free Secure\nPayment",
              ),
              _FeatureItem(icon: Icons.search, title: "Full\nTransparency"),
              _FeatureItem(
                icon: Icons.headset_mic,
                title: "Expert\nAssistance",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: AppColors.blackColor),
        const SizedBox(height: 6),
        CustomText(
          text: title,
          textAlign: TextAlign.center,
          fontSize: 13,
          color: Colors.black87,
        ),
      ],
    );
  }
}
