import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/models/car_model.dart';
import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import 'widgets/overview_section.dart';
import 'widgets/car_detail_section.dart';
import 'widgets/features_section.dart';

class CarDetailScreen extends StatefulWidget {
  final CarsModel obj;

  const CarDetailScreen({super.key, required this.obj});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  int selectedIndex = 0;
  int selectedSize = 0;
  final PageController _pageController = PageController();
  final ScrollController _tabScrollController = ScrollController();

  final List<String> items = ['Overview', 'Features', 'Car Details'];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).fetchCarDetails(context, widget.obj);
    });

    // Add listener to auto-scroll tabs when page changes
    _pageController.addListener(() {
      _autoScrollTabs(_pageController.page?.round() ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  // Method to auto-scroll tabs to keep selected tab visible
  void _autoScrollTabs(int index) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final double itemWidth = MediaQuery.of(context).size.width / items.length;
      final double screenWidth = MediaQuery.of(context).size.width;
      final double scrollPosition =
          (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

      _tabScrollController.animateTo(
        scrollPosition.clamp(
          0.0,
          _tabScrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Column(
            children: [
              /// TOP SECTION
              buildTopSection(context, provider),

              /// BOTTOM DETAIL SECTION
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildTitlePriceRow(),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 70,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.carDetailsModel.images.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 5),
                          itemBuilder: (context, index) => Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.greyColor.withAlpha(50),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                AppNavigation.navigateToCustomImageViewer(
                                  context,
                                  urls: provider.carDetailsModel.images,
                                  index: index,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      provider.carDetailsModel.images[index],
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
                      const SizedBox(height: 16),
                      buildTabBar(),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: AppColors.blackColor.withAlpha(10),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          children: [
                            AboutSection(
                              carDetailsModel: provider.carDetailsModel,
                            ),
                            SpecificationSection(
                              carDetailsModel: provider.carDetailsModel,
                            ),
                            CarsDetailSection(
                              carDetailsModel: provider.carDetailsModel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar:
              provider.isCarDetailLoading || provider.carDetailsModel.id.isEmpty
              ? SizedBox()
              : buildBottomBar(),
        );
      },
    );
  }

  // Build Top Visual and Button Section
  Widget buildTopSection(BuildContext context, DashboardProvider provider) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          Hero(
            tag: '${widget.obj.modelName}_${widget.obj.id}',
            child: GestureDetector(
              onTap: () {
                if (widget.obj.mainImageUrl.isNotEmpty) {
                  AppNavigation.navigateToCustomImageViewer(
                    context,
                    urls: [widget.obj.mainImageUrl],
                  );
                }
              },
              child: Container(
                color: AppColors.silverColor,
                child: CachedNetworkImage(
                  imageUrl: widget.obj.mainImageUrl,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                  placeholder: (context, url) => Center(
                    child: CupertinoActivityIndicator(
                      radius: 15,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.silverColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(height: 8),
                          const CustomText(
                            text: 'Failed to load image',
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 24,
              right: 24,
            ),
            child: Row(
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
          ),

          Positioned(
            bottom: 10,
            left: 24,
            right: 24,
            child: buildProductInfoRow(),
          ),
        ],
      ),
    );
  }

  // Product Info: Category & Rating
  Widget buildProductInfoRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.blackColor.withAlpha(90),
          ),
          child: CustomText(
            text: widget.obj.modelName,
            color: AppColors.whiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.blackColor.withAlpha(90),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppAssets.star, width: 18, height: 18),
              const SizedBox(width: 4),
              CustomText(
                text: '4.8 (365 reviews)',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ],
          ),
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
            text: widget.obj.makeName,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        RiyalPriceWidget(
          child: CustomText(
            text: widget.obj.listingPrice,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Tabs
  Widget buildTabBar() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        controller: _tabScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: items[index],
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 30, // Fixed width for the indicator
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Bottom Button
  Widget buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
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
                hasBorder: true,
                borderColor: AppColors.primaryColor,
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
