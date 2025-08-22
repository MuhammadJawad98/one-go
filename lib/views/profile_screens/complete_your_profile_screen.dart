import 'package:flutter/material.dart';

import '../../models/selection_object.dart';
import '../../routes/app_navigation.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/responsive.dart';

class CompleteYourProfileScreen extends StatefulWidget {
  const CompleteYourProfileScreen({super.key});

  @override
  State<CompleteYourProfileScreen> createState() =>
      _CompleteYourProfileScreenState();
}

class _CompleteYourProfileScreenState extends State<CompleteYourProfileScreen> {
  List<SelectionObject> genders = [
    SelectionObject(id: '1', title: 'Male'),
    SelectionObject(id: '2', title: 'Female'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = Responsive.getDynamicSize(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(child: Row(children: [CustomImageButton()])),
            const SizedBox(height: 24),

            // Title
            Center(
              child: CustomText(
                text: 'Complete Your Profile',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CustomText(
                  textAlign: TextAlign.center,
                  text:
                      'Don’t worry, only you can see your personal data. No one else will be able to see it.',
                  fontSize: 12,
                  color: AppColors.lightGreyTextColor,
                ),
              ),
            ),
            SizedBox(height: 24),

            ///profile image
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.fieldBgColor,
                    ),
                    child: Image.asset(AppAssets.person),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(AppAssets.edit, width: 40, height: 40),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36),

            CustomText(text: 'Name', fontSize: 12, color: AppColors.blackColor),
            SizedBox(height: 6),
            RoundedTextField(hintText: 'Ex. John Doe'),
            SizedBox(height: 20),
            CustomText(
              text: 'Phone Number',
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 6),
            RoundedTextField(hintText: 'Enter Phone Number'),
            SizedBox(height: 20),
            CustomText(
              text: 'Gender',
              fontSize: 12,
              color: AppColors.blackColor,
            ),
            SizedBox(height: 6),
            CustomDropDown(
              list: genders,
              onSelection: (item) {},
              title: '',
            ),

            SizedBox(height: 32),
            CustomButton(text: 'Complete Profile', onPressed: () {
              AppNavigation.navigateToLocationAllowScreen(context);
            }),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
