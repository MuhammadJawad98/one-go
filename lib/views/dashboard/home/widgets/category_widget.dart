import 'package:car_wash_app/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../widgets/custom_text.dart';

class CategoryWidget extends StatelessWidget {
  final Category obj;
  final VoidCallback onTap;

  const CategoryWidget({super.key, required this.obj, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: obj.isSelected ? AppColors.primaryColor : AppColors.fieldBgColor,
        ),
        child: Center(
          child: CustomText(
            text: obj.name,
            color: obj.isSelected ? AppColors.whiteColor : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
