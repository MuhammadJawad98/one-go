import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../models/car_model.dart';
import '../../../../routes/app_navigation.dart';
import '../../../../utils/app_colors.dart';

class PopularServiceWidget extends StatelessWidget {
  final CarsModel obj;

  const PopularServiceWidget({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateToServiceDetailScreen(context, obj);
      },
      child: SizedBox(
        width: 220,
        height: 180,
        child: Stack(
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: AppColors.greyColor,
                child: CachedNetworkImage(
                  imageUrl: obj.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Container(
                    color: AppColors.greyColor,
                    child: const Center(child: CupertinoActivityIndicator()),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.info, color: AppColors.whiteColor),
                ),
              ),
            ),

            // Favorite Button
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.whiteColor,
                child: Icon(
                  Icons.favorite_border,
                  color: AppColors.primaryColor,
                  size: 15,
                ),
              ),
            ),

            // Title Bar (positioned at bottom)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(80),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: obj.title,
                        color: AppColors.whiteColor,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.star, color: AppColors.yellowAppColor, size: 15),
                    const SizedBox(width: 2),
                    CustomText(
                      text: obj.averageRating?.toString() ?? '5.0',
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
