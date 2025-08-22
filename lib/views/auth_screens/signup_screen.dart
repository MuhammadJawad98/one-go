import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../../routes/app_navigation.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/social_icon_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordVisible = true;
  bool acceptTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    var size = Responsive.getDynamicSize(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: SizedBox()),
            SizedBox(height: 36),
            Center(
              child: CustomText(
                text: 'Create Account',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text:
                      'Fill your information below or register with your social account.',
                  fontSize: 12,
                  color: AppColors.lightGreyTextColor,
                ),
              ),
            ),
            SizedBox(height: 23),
            CustomText(text: 'Name', fontSize: 12, color: AppColors.blackColor),
            SizedBox(height: 6),
            RoundedTextField(hintText: 'Ex. John Doe'),
            SizedBox(height: 20),
            CustomText(
              text: 'Email',
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 6),
            RoundedTextField(hintText: 'example@gmail.com'),
            SizedBox(height: 20),
            CustomText(
              text: 'Password',
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 6),
            RoundedTextField(
              hintText: '********',
              obscureText: isPasswordVisible,
              sufixIcon: IconButton(
                onPressed: () =>
                    setState(() => isPasswordVisible = !isPasswordVisible),
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: acceptTermsAndConditions,
                  onChanged: (val) {
                    setState(() => acceptTermsAndConditions = val!);
                  },
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Agree with ',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Terms & Condition',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            CustomButton(text: 'Sign Up', onPressed: () {
              AppNavigation.navigateToOtpVerifyScreen(context);
            }),
            SizedBox(height: 43),
            Row(
              children: [
                Expanded(child: Divider()),
                SizedBox(width: 10),
                CustomText(text: ' Or sign up with '),
                SizedBox(width: 10),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 39),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSocialIconWidget(
                  image: AppAssets.appleIcon,
                  onTap: () {},
                ),
                SizedBox(width: 12),
                CustomSocialIconWidget(
                  image: AppAssets.googleIcon,
                  onTap: () {},
                ),
                SizedBox(width: 12),
                CustomSocialIconWidget(
                  image: AppAssets.facebookIcon,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 36),

            Center(
              child: GestureDetector(
                onTap: () {
                  AppNavigation.navigateToLoginScreen(context);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already  have an account? ',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
