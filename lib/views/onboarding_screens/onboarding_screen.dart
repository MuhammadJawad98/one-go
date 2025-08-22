import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:car_wash_app/utils/app_sharedpref.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../models/selection_object.dart'; // Make sure the model path is correct
import '../../utils/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> highlightKeywords = [
    'Exclusive Products',
    'Seamless Shopping',
    'Fast & Reliable Delivery',
  ];


  final List<SelectionObject> onboardingItems = [
    SelectionObject(
      title: 'Discover Exclusive Products',
      value: 'Explore a wide range of items from fashion to electronics.',
      image: AppAssets.onboarding1, // Product-related image (e.g., watches)
    ),
    SelectionObject(
      title: 'Enjoy Seamless Shopping',
      value: 'Add your favorites to cart and shop with ease.',
      image: AppAssets.onboarding2, // Shopping-related image
    ),
    SelectionObject(
      title: 'Fast & Reliable Delivery',
      value: 'Get your orders delivered quickly to your doorstep.',
      image: AppAssets.onboarding3, // Delivery-related image
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  TextSpan buildStyledTitle(String title) {
    final defaultStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    final highlightStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryColor,
    );

    for (String keyword in highlightKeywords) {
      if (title.contains(keyword)) {
        final parts = title.split(keyword);
        return TextSpan(
          style: defaultStyle,
          children: [
            TextSpan(text: parts[0]),
            TextSpan(text: keyword, style: highlightStyle),
            TextSpan(text: parts.length > 1 ? parts[1] : ''),
          ],
        );
      }
    }

    return TextSpan(text: title, style: defaultStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              final item = onboardingItems[index];

              return Stack(
                children: [
                  Image.asset(
                    item.image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: MediaQuery.sizeOf(context).height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: buildStyledTitle(item.title),
                          ),
                          const SizedBox(height: 24),
                          CustomText(
                            fontSize: 14,
                            color: AppColors.lightGreyTextColor,
                            text: item.value,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// ← Previous Button
                  _currentPage == 0
                      ? const SizedBox(width: 48)
                      : Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),

                  /// ••• Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingItems.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withAlpha(40),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  /// → Next / Done Button
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                      ),
                      onPressed: () {
                        if (_currentPage == onboardingItems.length - 1) {
                          HelperFunctions.saveInPreference(AppSharedPref.isFirstTime, '1');
                          AppNavigation.navigateToLoginScreen(context);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
