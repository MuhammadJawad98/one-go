import 'package:car_wash_app/models/selection_object.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class CategoryWidget extends StatelessWidget {
  final SelectionObject obj;

  const CategoryWidget({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: obj.isSelected ? AppColors.primaryColor : AppColors.fieldBgColor,
      ),
      child: Center(
        child: CustomText(
          text: obj.title,
          color: obj.isSelected ? AppColors.whiteColor : AppColors.primaryColor,
        ),
      ),
    );
  }
}
