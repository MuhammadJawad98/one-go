import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomRoundImage extends StatelessWidget {
  final Size size;
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;

  const CustomRoundImage({
    super.key,
    required this.size,
    required this.imageUrl,
    this.width,
    this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    double finalWidth = width ?? size.width * 0.2;
    double finalHeight = height ?? size.width * 0.2;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 15.0),
      child: Container(
        width: finalWidth,
        height: finalHeight,
        color: AppColors.greyColor.withAlpha(50),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: finalWidth,
          height: finalHeight,
          placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error_outline, color: Colors.white),
          ),
        ),
      ),
    );
  }
}