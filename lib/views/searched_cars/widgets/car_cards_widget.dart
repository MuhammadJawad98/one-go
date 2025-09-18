import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/car_model.dart';
import '../../../routes/app_navigation.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/riyal_price_widget.dart';

class CarCard extends StatelessWidget {
  final CarsModel obj;

  const CarCard({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${obj.modelName}_${obj.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            AppNavigation.navigateToServiceDetailScreen(context, obj);
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.greyColor),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    // Car image
                    _buildCarImage(),
                    const SizedBox(width: 12),

                    // Expanded Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price
                          RiyalPriceWidget(
                            child: CustomText(
                              text: obj.listingPrice,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Car Name / Make
                          CustomText(
                            text: obj.makeName,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),

                          // Model Name
                          if (obj.modelName.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            CustomText(
                              text: obj.modelName,
                              fontSize: 12,
                              color: Colors.grey[600],
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],

                          // Year & Mileage Example
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 5),
                              CustomText(
                                text: obj.year,
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.speed,
                                  size: 14, color: Colors.grey),
                              const SizedBox(width: 5),
                              CustomText(
                                text: '${obj.mileage} Mileage',
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // FEATURED Badge → Top-right of the whole card
              if (obj.isFeatured)
                Positioned(
                  top: 10,
                  right: 10,
                  child: _buildFeaturedBadge(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.orangeColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CustomText(
        text: 'FEATURED',
        fontSize: 9,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 110,
        height: 80,
        color: Colors.grey[200],
        child: obj.mainImageUrl.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: obj.mainImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.primaryColor,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.directions_car,
            color: AppColors.greyColor,
          ),
        )
            : const Icon(
          Icons.directions_car,
          size: 40,
          color: AppColors.greyColor,
        ),
      ),
    );
  }
}
