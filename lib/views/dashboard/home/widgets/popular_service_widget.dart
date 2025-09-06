import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/car_model.dart';
import '../../../../routes/app_navigation.dart';
import '../../../../utils/app_colors.dart';

class FeatureSelectionWidget extends StatelessWidget {
  final CarsModel obj;

  const FeatureSelectionWidget({super.key, required this.obj});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${obj.modelName}_${obj.id}',
      child: Material(
        child: GestureDetector(
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
                      imageUrl: obj.mainImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: AppColors.greyColor,
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
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
                      color: AppColors.primaryColor.withAlpha(90),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: obj.makeName,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              RiyalPriceWidget(
                                color: AppColors.whiteColor,
                                child: CustomText(
                                  text: obj.listingPrice,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: AppColors.whiteColor,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.star,
                          color: AppColors.yellowAppColor,
                          size: 15,
                        ),
                        const SizedBox(width: 2),
                        CustomText(text: '5.0', color: AppColors.whiteColor),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: obj.isFeatured
                          ? AppColors.orangeColor
                          : AppColors.buttonBlueColor,
                    ),
                    child: CustomText(
                      text: obj.isFeatured ? 'FEATURED' : 'STANDARD',
                      fontSize: 10,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
