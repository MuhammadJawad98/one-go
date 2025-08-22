import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black87,
            Colors.grey.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: CustomText(text: 'Limited time!'),
          ),
          const SizedBox(height: 16),
          CustomText(
            text: 'Get Special Offer',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomText(
                text: 'Up to',
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: '40%',
                fontSize: 34,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text:
                  'All Washing Service Available | T&C Applied',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.redAccentColor,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: CustomText(
                  text: 'Claim',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
