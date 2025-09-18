import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../models/services_model.dart';
import '../../../routes/app_navigation.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/riyal_price_widget.dart';

class ServiceCardWidget extends StatelessWidget {
  final ServiceModel obj;

  const ServiceCardWidget({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${obj.name}_${obj.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            AppNavigation.navigateToServiceDetailsScreen(context, obj);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.greyColor)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Image
                Stack(
                  children: [
                    _buildCarImage(),
                    if (obj.isFeatured) _buildFeaturedBadge(),
                  ],
                ),

                const SizedBox(width: 12),

                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Title
                      CustomText(
                        text: obj.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Price
                      RiyalPriceWidget(
                        child: CustomText(
                          text: obj.price,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Category
                      Row(
                        children: [
                          Icon(Octicons.gear, size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: CustomText(
                              text: obj.categoryName,
                              fontSize: 12,
                              color: Colors.grey[700],
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // City
                      Row(
                        children: [
                          Icon(Octicons.location, size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: CustomText(
                              text: obj.cityName,
                              fontSize: 12,
                              color: Colors.grey[700],
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedBadge() {
    return Positioned(
      top: 6,
      left: 6,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomText(
          text: 'FEATURED',
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 90,
        width: 90,
        color: Colors.grey[200],
        child: obj.mainImageUrl.isNotEmpty
            ? CachedNetworkImage(
          imageUrl: obj.mainImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
          const Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) => Image.asset(
            AppAssets.carServicePlaceholder,
            fit: BoxFit.cover,
          ),
        )
            : Image.asset(
          AppAssets.carServicePlaceholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
