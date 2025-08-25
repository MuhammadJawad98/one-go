import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_back_button.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/car_model.dart';
import '../../widgets/custom_text.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<CarsModel> favoriteCars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  CustomImageButton(onTap: () {}),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(text: 'Favourites', fontSize: 16),
                    ),
                  ),
                  CustomImageButton(
                    asset: AppAssets.search,
                    onTap: () {
                      AppNavigation.navigateToSearchedItemsScreen(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: favoriteCars.isEmpty
                    ? const Center(child: Text("No favorites yet."))
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: favoriteCars.length,
                        itemBuilder: (context, index) {
                          final product = favoriteCars[index];
                          return FavoriteCard(product: product);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final CarsModel product;

  const FavoriteCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateToServiceDetailScreen(context, CarsModel());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey[300]!, // Outline color
            width: 1,
          ),
        ),
        child: Row(
          children: [
            /// Product Image with Rating Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: product.mainImageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image(
                        image: imageProvider,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    placeholder: (context, url) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.error_outline,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        CustomText(
                          text: '4.8',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            /// Info Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Category Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      text: 'Category',
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),

                  /// Title
                  CustomText(
                    text: product.makeName,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  /// Price Range
                  RiyalPriceWidget(
                    child: CustomText(
                      text: product.listingPrice,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            /// Bookmark Icon
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  // Remove from favorites
                },
                icon: const Icon(Icons.favorite, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
