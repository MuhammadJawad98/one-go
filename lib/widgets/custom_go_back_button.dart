import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomGoBackButton extends StatelessWidget {
  const CustomGoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.screenBgColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.chevron_left, size: 36),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const CustomText(
            text: 'Go Back',
            fontWeight: FontWeight.w600,
            fontSize: 15)
      ],
    );
  }
}
