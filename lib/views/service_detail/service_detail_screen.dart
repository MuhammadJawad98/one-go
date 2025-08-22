import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/models/car_model.dart';
import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/review_model.dart';
import '../../models/selection_object.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import 'widgets/about_section.dart';
import 'widgets/gallery_section.dart';
import 'widgets/review_section.dart';
import 'widgets/specification_section.dart';

class ServiceDetailScreen extends StatefulWidget {
  final CarsModel obj;

  const ServiceDetailScreen({super.key, required this.obj});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int selectedIndex = 0;
  int selectedSize = 0;

  final List<String> items = ['Details', 'Specifications', 'Reviews'];

  final List<ReviewModel> reviews = [
    ReviewModel(
      name: 'Ayesha Khan',
      userImage: 'https://i.pravatar.cc/150?img=1',
      rating: 4.5,
      reviewText:
          'Absolutely loved the dress! The material is soft and the fit is perfect. Delivery was quick too.',
      reviewImages: [
        'https://source.unsplash.com/400x400/?fashion,dress',
        'https://source.unsplash.com/400x400/?outfit',
      ],
    ),
    ReviewModel(
      name: 'Usman Ali',
      userImage: 'https://i.pravatar.cc/150?img=2',
      rating: 5.0,
      reviewText:
          'The jeans are great quality and very comfortable. I highly recommend them!',
      reviewImages: ['https://source.unsplash.com/400x400/?jeans,clothing'],
    ),
    ReviewModel(
      name: 'Sara Malik',
      userImage: 'https://i.pravatar.cc/150?img=3',
      rating: 3.5,
      reviewText:
          'Nice shirt but the color was slightly different than the photos.',
      reviewImages: ['https://source.unsplash.com/400x400/?shirt,style'],
    ),
    ReviewModel(
      name: 'Bilal Ahmed',
      userImage: 'https://i.pravatar.cc/150?img=4',
      rating: 4.0,
      reviewText: 'Really liked the packaging and quality. Will buy again.',
      reviewImages: [],
    ),
    ReviewModel(
      name: 'Fatima Noor',
      userImage: 'https://i.pravatar.cc/150?img=5',
      rating: 2.5,
      reviewText:
          'The size was too small even though I ordered my usual. Quality is good though.',
      reviewImages: ['https://source.unsplash.com/400x400/?clothes,return'],
    ),
  ];

  List<String> teslaCarImages = [
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-3-Main-Hero-Desktop-LHD.jpg',
    // Model 3
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
    // Model S
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-X-Main-Hero-Desktop-LHD.jpg',
    // Model X
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-Y-Main-Hero-Desktop-Global.jpg',
    // Model Y
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Cybertruck-Main-Hero-Desktop.jpg',
    // Cybertruck
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Roadster-Main-Hero-Desktop.jpg',
    // Roadster
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-3-Performance-Hero-Desktop.jpg',
    // Model 3 Performance
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Plaid-Hero-Desktop-LHD.jpg',
    // Model S Plaid
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-X-Plaid-Hero-Desktop-LHD.jpg',
    // Model X Plaid
    'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-Y-Performance-Hero-Desktop-Global.jpg',
    // Model Y Performance
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// TOP SECTION
          Expanded(flex: 2, child: buildTopSection(context)),

          /// BOTTOM DETAIL SECTION
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProductInfoRow(),
                  const SizedBox(height: 10),
                  buildTitlePriceRow(),
                  // const SizedBox(height: 5),
                  // CustomText(
                  //   text: 'Outwear Men',
                  //   fontSize: 14,
                  //   fontWeight: FontWeight.w500,
                  //   color: AppColors.lightGreyTextColor,
                  // ),
                  const SizedBox(height: 16),
                  buildTabBar(),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: AppColors.blackColor.withAlpha(10),
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: getSelectedTab()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  // Build Top Visual and Button Section
  Widget buildTopSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: AppColors.silverColor,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 12),
              Row(
                children: [
                  CustomImageButton(
                    bgColor: AppColors.whiteColor,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  CustomImageButton(
                    asset: AppAssets.shareIcon,
                    bgColor: AppColors.whiteColor,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.whiteColor),
                        shape: BoxShape.circle,
                        color: AppColors.whiteColor,
                      ),
                      child: Icon(
                        Icons.favorite,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.demoVideoColor.withAlpha(90),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_circle, color: AppColors.whiteColor),
                const SizedBox(width: 12),
                CustomText(text: 'Demo Video', color: AppColors.whiteColor),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteColor,
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: teslaCarImages.length,
              separatorBuilder: (_, __) => const SizedBox(width: 5),
              itemBuilder: (context, index) => Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.greyColor.withAlpha(50),
                ),
                child: GestureDetector(
                  onTap: (){
                    AppNavigation.navigateToCustomImageViewer(context, urls: teslaCarImages,index: index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: teslaCarImages[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CupertinoActivityIndicator(
                          radius: 10,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error_outline,
                          color: AppColors.greyColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Product Info: Category & Rating
  Widget buildProductInfoRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.fieldBgColor,
          ),
          child: CustomText(
            text: 'Category',
            color: AppColors.primaryColor,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Image.asset(AppAssets.star, width: 18, height: 18),
        const SizedBox(width: 4),
        CustomText(
          text: '4.8 (365 reviews)',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.lightGreyTextColor,
        ),
      ],
    );
  }

  // Product Name and Price
  Widget buildTitlePriceRow() {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: widget.obj.title,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        RiyalPriceWidget(child: CustomText(text: '68.0', fontSize: 14)),
      ],
    );
  }

  // Tabs
  Widget buildTabBar() {
    return SizedBox(
      height: 40,
      child: Row(
        children: List.generate(items.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = index),
              child: Column(
                children: [
                  CustomText(
                    text: items[index],
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Tab Content
  Widget getSelectedTab() {
    switch (selectedIndex) {
      case 0:
        return AboutSection(
          // sizes: sizes,
          selectedSize: selectedSize,
          onSizeChanged: (int value) {
            setState(() => selectedSize = value);
          },
        );
      case 1:
        return SpecificationSection();
      // case 2:
      //   return ProductGallerySection(galleryImages: galleryImages);
      case 2:
        return ReviewSection(reviews: reviews);
      default:
        return const SizedBox.shrink();
    }
  }

  // Bottom Button
  Widget buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SafeArea(
        bottom: true,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Book a Visit',
                backgroundColor: AppColors.primaryColor.withAlpha(50),
                textColor: AppColors.primaryColor,
                borderRadius: 12,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomButton(text: 'Make Your Deal', borderRadius: 12),
            ),
          ],
        ),
      ),
    );
  }
}
