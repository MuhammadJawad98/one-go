import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final double? width;
  final double? fontSize;
  final bool isLoading;
  final bool hasBorder;
  final int? maxLine;
  final Widget? trailingWidget;

  const CustomButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.backgroundColor = AppColors.primaryColor,
      this.textColor = AppColors.whiteColor,
      this.borderRadius = 50.0,
      this.padding = 16.0,
      this.isLoading = false,
      this.hasBorder = false,
      this.borderColor,
      this.maxLine,
      this.width,
      this.fontSize,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: isLoading ? null : onPressed,
        child: SizedBox(
          width: width,
          child: Container(
            padding: EdgeInsets.all(padding),
            constraints: BoxConstraints(minWidth: 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: hasBorder
                    ? Border.all(
                        color: borderColor != null
                            ? borderColor!
                            : AppColors.primaryColor)
                    : null),
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppColors.whiteColor))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: text,
                        color: textColor,
                        fontSize: fontSize ?? 15,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        maxLine: maxLine,
                      ),
                      if (trailingWidget != null) ...[
                        const SizedBox(width: 10),
                        trailingWidget!
                      ]
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? fontSize;
  final double? width;

  const CustomOutlineButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.fontSize,
      this.width});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: text,
        width: width,
        fontSize: fontSize,
        hasBorder: true,
        backgroundColor: AppColors.whiteColor,
        textColor: AppColors.primaryColor,
        onPressed: onPressed);
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;

  const CustomTextButton(
      {super.key, this.onTap, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: CustomText(
            text: text,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: color ?? AppColors.primaryColor));
  }
}
