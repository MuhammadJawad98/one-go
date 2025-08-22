import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final String? fontFamily;
  final double? height;

  const CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.textOverflow,
      this.fontFamily,
      this.height, this.decorationColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: textOverflow,
      style: TextStyle(
          fontFamily: fontFamily,
          decoration: textDecoration,
          decorationColor: decorationColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height),
    );
  }
}
