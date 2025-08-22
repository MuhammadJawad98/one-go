import 'package:car_wash_app/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class AllowNotificationScreen extends StatefulWidget {
  const AllowNotificationScreen({super.key});

  @override
  State<AllowNotificationScreen> createState() =>
      _AllowNotificationScreenState();
}

class _AllowNotificationScreenState extends State<AllowNotificationScreen> {
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
                child: Image.asset(AppAssets.notificationBing),
              ),
            ),
            SizedBox(height: 36),
            Center(
              child: CustomText(
                text: 'Enable Notification Access',
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: CustomText(
                textAlign: TextAlign.center,
                text: 'Enable notifications to receive real-time updates . ',
                fontSize: 12,
                color: AppColors.lightGreyTextColor,
              ),
            ),
            SizedBox(height: 36),

            CustomButton(text: 'Allow Notification', onPressed: () {}),
            SizedBox(height: 12),
            CustomButton(
              text: 'Maybe Later',
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.primaryColor,
              onPressed: () {
                // AppNavigation.navigateToManuallyLocationEnterScreen(context);
              },
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
