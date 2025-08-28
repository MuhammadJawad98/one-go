import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_wash_app/models/services_model.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../widgets/riyal_price_widget.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/custom_back_button.dart';
import '../../routes/app_navigation.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import 'sections/about_service_section.dart';
import 'sections/contact_info_section.dart';
import 'sections/operation_hour_selection.dart';
import 'sections/service_specification_section.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ServiceModel obj;

  const ServiceDetailScreen({
    super.key,
    required this.obj,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _tabScrollController = ScrollController();
  final List<String> items = [
    'Overview',
    'Specifications',
    'Operating Hours',
    'Contact Info',
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).fetchServiceDetails(context, widget.obj.id);
    });
    // Add listener to auto-scroll tabs when page changes
    _pageController.addListener(() {
      _autoScrollTabs(_pageController.page?.round() ?? 0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabScrollController.dispose(); // Dispose the tab controller
    super.dispose();
  }

  // Method to auto-scroll tabs to keep selected tab visible
  void _autoScrollTabs(int index) {
    final double itemWidth = 150; // Approximate width of each tab item
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scrollPosition =
        (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    _tabScrollController.animateTo(
      scrollPosition.clamp(0.0, _tabScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
                            buildTitlePriceRow(provider),
                            const SizedBox(height: 10),

                            /// Tags
                            if (provider.serviceDetail.tags.isNotEmpty)
                              SizedBox(
                                height: 30,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.serviceDetail.tags.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 8),
                                  itemBuilder: (context, index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: AppColors.screenBgColor,
                                    ),
                                    child: CustomText(
                                      text: provider.serviceDetail.tags[index],
                                      fontSize: 12,
                                      color: AppColors.primaryColor,
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
                                  AboutServiceSection(
                                    serviceDetail: provider.serviceDetail,
                                  ),
                                  ServiceSpecificationSection(
                                    serviceDetail: provider.serviceDetail,
                                  ),
                                  OperatingHoursSection(
                                    operatingHours:
                                        provider.serviceDetail.operatingHours,
                                  ),
                                  ContactInfoSection(
                                    serviceDetail: provider.serviceDetail,
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
              provider.isServicesLoading || provider.serviceDetail.id.isEmpty
              ? const SizedBox()
              : buildBottomBar(provider),
        );
      },
    );
  }

  // Build Top Visual and Button Section
  Widget buildTopSection(BuildContext context, DashboardProvider provider) {
    return Stack(
      children: [
        Hero(
          tag: '${widget.obj.name}_${widget.obj.id}',
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
              height: 300,
              width: double.infinity,
              color: AppColors.silverColor,
              child: widget.obj.mainImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.obj.mainImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CupertinoActivityIndicator(
                          radius: 15,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(AppAssets.carServicePlaceholder),
                    )
                  : Image.asset(
                      AppAssets.carServicePlaceholder,
                      fit: BoxFit.cover,
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
                onTap: () {
                  // Share service functionality
                },
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  // Toggle favorite
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
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
          child: buildServiceInfoRow(provider),
        ),
      ],
    );
  }

  // Service Info: Category & Featured Badge
  Widget buildServiceInfoRow(DashboardProvider provider) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.fieldBgColor,
          ),
          child: CustomText(
            text: provider.serviceDetail.categoryName,
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        if (provider.serviceDetail.isFeatured)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.orangeColor,
            ),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16, color: AppColors.whiteColor),
                const SizedBox(width: 4),
                CustomText(
                  text: 'Featured',
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

  // Service Name and Price
  Widget buildTitlePriceRow(DashboardProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: provider.serviceDetail.name,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: provider.serviceDetail.businessName,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            RiyalPriceWidget(
              child: CustomText(
                text: provider.serviceDetail.price,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Material(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(100),
              child: InkWell(
                onTap: () {
                  var lat = provider.serviceDetail.branchLatitude;
                  var lng = provider.serviceDetail.branchLongitude;
                  if (lat.isNotEmpty && lng.isNotEmpty) {
                    HelperFunctions.openLocationInGoogleMaps(lat, lng);
                  }
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Transform.rotate(
                    angle: 0.785,
                    child: Icon(
                      Icons.navigation_outlined,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
  Widget buildBottomBar(DashboardProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Contact Now',
                backgroundColor: AppColors.primaryColor.withAlpha(50),
                textColor: AppColors.primaryColor,
                borderRadius: 12,
                hasBorder: true,
                borderColor: AppColors.primaryColor,
                onPressed: () {
                  // Contact functionality
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Book Service',
                borderRadius: 12,
                onPressed: () {
                  // Book service functionality
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
