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
  List<CarsModel> favoriteCars = [
    CarsModel(
      id: '1',
      title: '2023 Porsche 911 Turbo S',
      image:
          'https://cdn.porsche.com/usa/models/911/911-turbo-s/992/gallery/911-turbo-s-992-gallery-01.jpg',
      price: 207000,
      brand: 'Porsche',
      category: 'Sports Car',
      description:
          '640hp twin-turbo flat-6 engine, 0-60mph in 2.6 seconds with rear-axle steering',
      averageRating: 4.9,
      reviewCount: 342,
      availableColors: ['GT Silver Metallic', 'Carmine Red', 'Jet Black'],
      discount: 5,
    ),
    CarsModel(
      id: '2',
      title: '2023 Mercedes-Benz S-Class S 580',
      image:
          'https://www.mbusa.com/content/dam/mb-nafta/us/myco/my23/s-class/sedan/overview/hero/2023-S-CLASS-SEDAN-HERO-DR.jpg',
      price: 118000,
      brand: 'Mercedes-Benz',
      category: 'Luxury Sedan',
      description:
          '496hp V8 with rear-axle steering, MBUX hyperscreen and executive rear seating',
      averageRating: 4.8,
      reviewCount: 287,
      availableColors: ['Obsidian Black', 'Selenite Grey', 'Rubellite Red'],
    ),
    CarsModel(
      id: '3',
      title: '2023 Land Rover Range Rover SV',
      image:
          'https://www.landroverusa.com/content/dam/land-rover/images/range-rover/2023/overview/range-rover-sv-overview-desktop.jpg',
      price: 180000,
      brand: 'Land Rover',
      category: 'Luxury SUV',
      description:
          '523hp V8 with executive rear seats, premium leather interiors and terrain response',
      averageRating: 4.7,
      reviewCount: 198,
      availableColors: ['Santorini Black', 'Lantau Bronze', 'Arctic White'],
      discount: 8,
    ),
    CarsModel(
      id: '4',
      title: '2023 Audi RS e-tron GT',
      image:
          'https://www.audi.com/content/dam/gbp2/models/rs/e-tron-gt/rs-e-tron-gt/overview/1920x1080/1920x1080-rs-e-tron-gt-01.jpg',
      price: 142000,
      brand: 'Audi',
      category: 'Electric',
      description:
          '637hp all-electric with 238mi range, 0-60mph in 3.1s and quattro AWD',
      averageRating: 4.8,
      reviewCount: 231,
      availableColors: ['Tactical Green', 'Daytona Gray', 'Ultra Blue'],
    ),
    CarsModel(
      id: '5',
      title: '2023 BMW M5 Competition',
      image:
          'https://www.bmwusa.com/content/dam/bmw/common/all-models/m-series/m5-sedan/2023/overview/bmw-m5-cs-overview-desktop.jpg',
      price: 112000,
      brand: 'BMW',
      category: 'Performance Sedan',
      description:
          '617hp twin-turbo V8 with M xDrive AWD and carbon ceramic brakes',
      averageRating: 4.7,
      reviewCount: 312,
      availableColors: [
        'Frozen Marina Bay Blue',
        'Black Sapphire',
        'Imola Red',
      ],
      discount: 3,
    ),
  ];

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
        AppNavigation.navigateToServiceDetailScreen(
          context,
          CarsModel(id: 'id', title: 'title', image: 'image', price: 0),
        );
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
                    imageUrl: product.image,
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
                    text: product.title,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  /// Price Range
                  RiyalPriceWidget(
                    child: CustomText(
                      text: '${product.price}',
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
