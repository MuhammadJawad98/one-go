import 'package:car_wash_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/custom_text.dart';

class StatusChip extends StatelessWidget {
  final String text;
  final Color color;

  const StatusChip({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(12),
        border: Border.all(color: color.withAlpha(35)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: CustomText(
        text: text,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      ),
    );
  }
}
