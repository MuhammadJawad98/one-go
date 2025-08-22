import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class LocationAllowScreen extends StatefulWidget {
  const LocationAllowScreen({super.key});

  @override
  State<LocationAllowScreen> createState() => _LocationAllowScreenState();
}

class _LocationAllowScreenState extends State<LocationAllowScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///profile image
            Center(
              child: Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(31),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.fieldBgColor,
                ),
                child: Image.asset(AppAssets.location),
              ),
            ),
            SizedBox(height: 36),
            Center(
              child: CustomText(
                text: 'What is Your Location?',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),

            Center(
              child: CustomText(
                textAlign: TextAlign.center,
                text: 'To Find Nearby Service Provider.',
                fontSize: 12,
                color: AppColors.lightGreyTextColor,
              ),
            ),
            SizedBox(height: 36),

            CustomButton(text: 'Allow Location Access', onPressed: () {
              AppNavigation.navigateToAllowNotificationScreen(context);
            }),
            SizedBox(height: 12),
            CustomButton(
              text: 'Enter Location Manually',
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.primaryColor,
              onPressed: () {
                AppNavigation.navigateToManuallyLocationEnterScreen(context);
              },
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
