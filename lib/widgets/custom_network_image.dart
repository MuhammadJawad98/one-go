import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Size size;
  final BoxFit fit;
  final bool hasBorder;
  final double radius;

  const CustomNetworkImage(
      {Key? key,
      required this.url,
      this.width,
      this.height,
      required this.size, this.fit=BoxFit.cover,this.hasBorder=false,this.radius=0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        width: width ?? double.infinity,
        height: height ?? size.width * 0.5,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child; // While the image is still loading, show the child widget.
          }
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: AppColors.lightGreyColor,border: hasBorder? Border.all(color: AppColors.primaryColor):null),
            width: width ?? double.infinity,
            height: height ?? size.width * 0.5,
            child: const CupertinoActivityIndicator(),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: AppColors.lightGreyColor),
            width: width ?? double.infinity,
            height: height ?? size.width * 0.5,
            child: const Center(child: Icon(Icons.error)),
          );
        },
      ),
    );
  }
}
