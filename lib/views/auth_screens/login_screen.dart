import 'package:car_wash_app/providers/auth_provider.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/app_assets.dart';
import 'package:car_wash_app/widgets/custom_button.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/custom_text_field.dart';
import 'package:car_wash_app/widgets/social_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool isPasswordVisible = true;
  var numberTf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              top: true,
              left: false,
              right: false,
              bottom: false,
              child: Center(
                child: Image.asset(AppAssets.logo, width: 150, height: 150),
              ),
            ),
            Center(
              child: CustomText(
                text: 'Sign In',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: CustomText(
                text: 'Hi! Welcome back, you’ve been missed',
                fontSize: 12,
                color: AppColors.lightGreyTextColor,
              ),
            ),
            SizedBox(height: 56),
            CustomText(
              text: 'Mobile No.',
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 6),
            RoundedTextField(
              hintText: '966*********',
              controller: numberTf,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
              ],
            ),
            SizedBox(height: 20),
            // CustomText(
            //   text: 'Password',
            //   fontSize: 12,
            //   color: AppColors.blackColor,
            // ),
            // SizedBox(height: 6),
            // RoundedTextField(
            //   hintText: '********',
            //   obscureText: isPasswordVisible,
            //   sufixIcon: IconButton(
            //     onPressed: () =>
            //         setState(() => isPasswordVisible = !isPasswordVisible),
            //     icon: Icon(
            //       isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            //       color: AppColors.blackColor,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 12),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: CustomText(
            //       text: 'Forgot Password?',
            //       fontSize: 12,
            //       color: AppColors.primaryColor,
            //       textDecoration: TextDecoration.underline,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 32),
            Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return CustomButton(
                  text: 'Sign In',
                  isLoading: provider.isLoginLoading,
                  onPressed: () {
                    provider.doLogin(context, numberTf.text.trim());
                    // AppNavigation.navigateToDashboardScreen(context);
                    // AppNavigation.navigateToOtpVerifyScreen(context);
                  },
                );
              },
            ),
            SizedBox(height: 43),
            Row(
              children: [
                Expanded(child: Divider()),
                SizedBox(width: 10),
                CustomText(text: ' Or sign in with '),
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
                  AppNavigation.navigateToSignupScreen(context);
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
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
