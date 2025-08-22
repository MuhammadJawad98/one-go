import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_colors.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final Widget? customPrefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final double? borderRadius;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Function(String)? onChange;
  final VoidCallback? onEditDone;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool centerText;
  final Color? bgColor;

  const RoundedTextField(
      {super.key,
      this.hintText = '',
      this.icon,
      this.controller,
      this.autoFocus = false,
      this.focusNode,
      this.enabled = true,
      this.borderRadius,
      this.customPrefixIcon,
      this.sufixIcon,
      this.maxLines = 1,
      this.maxLength,
      this.keyboardType,
      this.hintStyle,
      this.textStyle,
      this.onChange,
      this.onEditDone,
      this.inputFormatters,this.obscureText=false,this.prefixIcon, this.centerText = false, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          color: bgColor ?? AppColors.fieldBgColor,
          // border: Border.all(color: AppColors.greyColor)
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        style: textStyle,
        onChanged: onChange,
        onEditingComplete: onEditDone,
        inputFormatters: inputFormatters,
        autofocus: autoFocus,
        focusNode: focusNode,
        obscureText: obscureText,
        cursorColor: AppColors.primaryColor,
        textAlign: centerText ? TextAlign.center : TextAlign.start,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: sufixIcon,
          prefixIcon: prefixIcon,
          hintStyle: hintStyle,
          icon: customPrefixIcon ??
              (icon != null
                  ? Icon(icon, color: AppColors.greyColor)
                  : null),
          border: InputBorder.none, // No border
        ),
      ),
    );
  }
}
