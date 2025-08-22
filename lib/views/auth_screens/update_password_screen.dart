import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/responsive.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isPasswordVisible = false;
  bool isPasswordConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = Responsive.getDynamicSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SafeArea(child: Row(children: [CustomImageButton()])),
            const SizedBox(height: 24),

            // Title
            Center(
              child: CustomText(
                text: 'New Password',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text:
                      'Your new password must be different from previously used passwords.',
                  fontSize: 12,
                  color: AppColors.lightGreyTextColor,
                ),
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: 'Password',
                fontSize: 12,
                color: AppColors.blackColor,
              ),
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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: 'Confirm Password',
                fontSize: 12,
                color: AppColors.blackColor,
              ),
            ),
            SizedBox(height: 6),
            RoundedTextField(
              hintText: '********',
              obscureText: isPasswordConfirmVisible,
              sufixIcon: IconButton(
                onPressed: () => setState(
                  () => isPasswordConfirmVisible = !isPasswordConfirmVisible,
                ),
                icon: Icon(
                  isPasswordConfirmVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(height: 32),
            CustomButton(text: 'Create New Password', onPressed: () {
              AppNavigation.navigateToCompleteYourProfileScreen(context);
            }),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
