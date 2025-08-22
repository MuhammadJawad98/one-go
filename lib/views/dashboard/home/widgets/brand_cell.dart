import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/models/selection_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';

class BrandCellWidget extends StatelessWidget {
  final SelectionObject obj;
  final double? width;
  final double? height;

  const BrandCellWidget({
    super.key,
    required this.obj,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.fieldBgColor,
      ),
      child: Center(
        child: CachedNetworkImage(
          imageUrl: obj.image,
          width: 80,
          height: 100,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              const CupertinoActivityIndicator(radius: 12, animating: true),
          errorWidget: (context, url, error) => Center(
            child: const Icon(Icons.broken_image, color: Colors.grey, size: 24),
          ),
        ),
      ),
    );
  }
}
