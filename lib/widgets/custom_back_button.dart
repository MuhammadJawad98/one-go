import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class CustomImageButton extends StatelessWidget {
  final Color? color;
  final Color? bgColor;
  final String? asset;
  final VoidCallback? onTap;

  const CustomImageButton({super.key, this.color, this.onTap, this.asset, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color:AppColors.greyColor),
          shape: BoxShape.circle,
          color: bgColor
        ),
        child: Image.asset(asset ?? AppAssets.arrowLeft,color: color ?? AppColors.blackColor,width: 20,height: 20),
      ),
    );
  }
}
