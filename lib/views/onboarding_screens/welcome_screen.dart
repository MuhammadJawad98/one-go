import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_button.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Responsive.getDynamicSize(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.welcomeScreenBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Discover, Shop, and Save - ',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: 'All in One Place',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text:
                          'Browse the latest deals, trending products, and everything you love — delivered to your doorstep.',
                      textAlign: TextAlign.center,
                      color: AppColors.lightGreyTextColor,
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Let’s Get Started',
                      onPressed: () {
                        AppNavigation.navigateToOnboardingScreen(context);
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        AppNavigation.navigateToLoginScreen(context);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
