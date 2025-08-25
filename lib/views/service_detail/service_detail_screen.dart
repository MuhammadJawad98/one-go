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
import 'widgets/about_section.dart';
import 'widgets/car_detail_section.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: provider.isCarDetailLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : Column(
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
                                itemCount:
                                    provider.carDetailsModel.images.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 5),
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
                                        imageUrl: provider
                                            .carDetailsModel
                                            .images[index],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 10,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
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
                            Expanded(child: getSelectedTab()),
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
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.obj.mainImageUrl.isNotEmpty) {
              AppNavigation.navigateToCustomImageViewer(
                context,
                urls: [widget.obj.mainImageUrl],
              );
            }
          },
          child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 24),
            color: AppColors.silverColor,
            child: CachedNetworkImage(
              imageUrl: widget.obj.mainImageUrl,
              fit: BoxFit.cover,
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

        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     padding: const EdgeInsets.all(12),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: AppColors.demoVideoColor.withAlpha(90),
        //     ),
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         const Icon(Icons.play_circle, color: AppColors.whiteColor),
        //         const SizedBox(width: 12),
        //         CustomText(text: 'Demo Video', color: AppColors.whiteColor),
        //       ],
        //     ),
        //   ),
        // ),
      ],
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
            color: AppColors.fieldBgColor,
          ),
          child: CustomText(
            text: widget.obj.modelSlug,
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
          color: AppColors.whiteColor,
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
          child: CustomText(text: widget.obj.listingPrice, fontSize: 14),
        ),
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
        return AboutSection();
      case 1:
        return SpecificationSection();
      // case 2:
      //   return ProductGallerySection(galleryImages: galleryImages);
      case 2:
        return CarsDetailSection(reviews: []);
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
