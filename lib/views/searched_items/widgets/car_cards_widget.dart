import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/models/car_model.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final CarsModel obj;

  const CarCard({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateToServiceDetailScreen(context, obj);
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured badge
            // Car image
            Stack(
              children: [
                _buildCarImage(),
                if (obj.isFeatured)
                  Positioned(top: 10, left: 10, child: _buildFeaturedBadge()),
              ],
            ),

            // Price
            SizedBox(height: 8),
            RiyalPriceWidget(
              child: CustomText(
                text: obj.price.toStringAsFixed(2),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Title
            SizedBox(height: 4),
            CustomText(
              text: obj.title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLine: 2,
              textOverflow: TextOverflow.ellipsis,
            ),

            // Rating (if available)
            if (obj.averageRating != null) _buildRatingRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(4),
        ),
        child: CustomText(
          text: 'FEATURED',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.amber[600],
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: obj.image.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: obj.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.info, color: AppColors.greyColor),
                ),
              )
            : const Icon(Icons.info, color: AppColors.greyColor),
      ),
    );
  }

  Widget _buildRatingRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          ...List.generate(5, (index) {
            return Icon(
              Icons.star,
              size: 14,
              color: index < obj.averageRating!.floor()
                  ? Colors.amber
                  : Colors.grey[300],
            );
          }),
          CustomText(
            text:
                ' ${obj.averageRating}${obj.reviewCount != null ? ' (${obj.reviewCount})' : ''}',
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
