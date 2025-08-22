import 'package:car_wash_app/routes/app_navigation.dart';

import '../../../models/car_model.dart';
import '../../../models/selection_object.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../views/dashboard/home/widgets/brand_cell.dart';
import '../../../views/dashboard/home/widgets/popular_service_widget.dart';
import '../../../views/dashboard/home/widgets/category_widget.dart';
import '../../../views/dashboard/home/widgets/special_offer_widget.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  List<SelectionObject> types = [
    SelectionObject(id: '1',title: 'All Status',isSelected: true),
    SelectionObject(id: '2',title: 'Used Cars'),
    SelectionObject(id: '3',title: 'New Cars'),
  ];

  List<SelectionObject> make = [
    SelectionObject(id: '1',title: 'Audi',isSelected: true),
    SelectionObject(id: '2',title: 'Bentley'),
    SelectionObject(id: '3',title: 'BMW'),
    SelectionObject(id: '4',title: 'Ford'),
    SelectionObject(id: '5',title: 'Honda'),
    SelectionObject(id: '6',title: 'Mercedes'),
  ];

  List<SelectionObject> models = [
    SelectionObject(id: '1',title: 'A3'),
    SelectionObject(id: '2',title: 'A4'),
    SelectionObject(id: '3',title: 'A5'),
    SelectionObject(id: '4',title: 'A6'),
  ];

  List<SelectionObject> prices = [
    SelectionObject(id: '1',title: 'No Max Price'),
    SelectionObject(id: '2',title: '2000'),
    SelectionObject(id: '3',title: '5000'),
    SelectionObject(id: '4',title: '10000'),
    SelectionObject(id: '5',title: '20000'),
    SelectionObject(id: '6',title: '30000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Welcome,',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text: provider.userModel.name,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomImageButton(asset: AppAssets.search, onTap: () {
                        _showFilterBottomSheet();
                      }),
                      SizedBox(width: 10),
                      CustomImageButton(
                        asset: AppAssets.notificationBing,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200,
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SpecialOfferWidget(),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == index ? 24 : 8,  // Longer when selected
                                height: 8,  // Consistent height
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),  // Makes it oval when longer
                                  color: _currentPage == index
                                      ? AppColors.primaryColor
                                      : Colors.grey.shade400,
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 12),

                          CustomText(
                            text: 'Category',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 12),

                          SizedBox(
                            height: 35,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return CategoryWidget(obj: provider.categories[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 12);
                              },
                              itemCount: provider.categories.length,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Top Brands',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: 'See All',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return BrandCellWidget(obj: provider.topCarBrandsInSaudi[index]);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 12);
                              },
                              itemCount: provider.topCarBrandsInSaudi.length,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Featured Selections',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: 'See All',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return PopularServiceWidget(obj: CarsModel(id: '1', title: 'Tesla model S', image: 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dGVzbGF8ZW58MHx8MHx8fDA%3D', price: 0,averageRating: 5.0));
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 16);
                              },
                              itemCount: 10,
                            ),
                          ),
                          SizedBox(height: 12),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Important for rounded corners
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: CustomText(text:
                      'Filter Options',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Divider(height: 1),
              SizedBox(height: 16),
              CustomText(text: 'Type'),
              SizedBox(height: 5),
              CustomDropDown(list: types, onSelection: (item){}, title: 'Type'),
              SizedBox(height: 16),
              CustomText(text: 'Make'),
              SizedBox(height: 5),
              CustomDropDown(list: make, onSelection: (item){}, title: 'Make'),
              SizedBox(height: 16),
              CustomText(text: 'Model'),
              SizedBox(height: 5),
              CustomDropDown(list: models, onSelection: (item){}, title: 'Model'),
              SizedBox(height: 16),
              CustomText(text: 'Model'),
              SizedBox(height: 5),
              CustomDropDown(list: prices, onSelection: (item){}, title: 'Model'),
              SizedBox(height: 24),

              // Search button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  text: 'Search',
                  onPressed: () {
                    Navigator.pop(context);
                    AppNavigation.navigateToSearchedItemsScreen(context);
                    // Add your search navigation logic here
                  },
                ),
              ),
              SafeArea(child: SizedBox(height: 16))
            ],
          ),
        );
      },
    );
  }


}

/*
Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      AppAssets.homeBg,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 194,
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Location',
                                      fontSize: 12,
                                      color: AppColors.whiteColor,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.locationHomeTop,
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: 4),
                                        Flexible(
                                          child: CustomText(
                                            text: 'New York, USA',
                                            fontSize: 14,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: AppColors.redAccentColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 38,
                                height: 38,
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.whiteColor.withAlpha(17),
                                ),
                                child: Image.asset(
                                  AppAssets.notificationBing,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 55,
                                  child: RoundedTextField(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Image.asset(
                                        AppAssets.search,
                                        width: 24,
                                      ),
                                    ),
                                    hintText: 'Search',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 55,
                                height: 55,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.whiteColor,
                                ),
                                child: Image.asset(AppAssets.filter),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: '#SpecialForYou',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: 'See All',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: SpecialOfferWidget()
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 12 : 8,
                            height: _currentPage == index ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade400,
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     CustomText(
                      //       text: 'Services',
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //     CustomText(
                      //       text: 'See All',
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w400,
                      //       color: AppColors.primaryColor,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 16),

                      SizedBox(
                        height: 35,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ServiceWidget(obj: provider.categories[index]);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 12);
                          },
                          itemCount: provider.categories.length,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Popular Products',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: 'See All',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        height: 220,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return PopularServiceWidget(obj: ProductModel(id: 'id', title: 'title', image: 'image', price: 0));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 16);
                          },
                          itemCount: 10,
                        ),
                      ),
                      SizedBox(height: 50)
                    ],
                  ),
                ),
              ),
            ],
          ),
 */
