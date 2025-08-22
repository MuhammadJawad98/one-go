import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../widgets/custom_bottom_nav_section.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  CustomImageButton(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: 'Profile',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<DashboardProvider>(
                      builder: (context, provider, child) {
                        return Center(
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
                                child: provider.userModel.profilePictureUrl.isNotEmpty ? CachedNetworkImage(imageUrl: provider.userModel.profilePictureUrl) :Image.asset(AppAssets.person),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    AppAssets.edit,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'Name',
                      fontSize: 12,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: 6),
                    RoundedTextField(hintText: ''),
                    SizedBox(height: 16),
                    CustomText(
                      text: 'Phone Number',
                      fontSize: 12,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: 6),
                    RoundedTextField(hintText: ''),

                    SizedBox(height: 16),
                    CustomText(
                      text: 'Email',
                      fontSize: 12,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: 6),
                    RoundedTextField(hintText: ''),

                    SizedBox(height: 16),
                    CustomText(
                      text: 'Gender',
                      fontSize: 12,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: 6),
                    Consumer<DashboardProvider>(
                      builder: (context, provider, child) {
                        return CustomDropDown(list: provider.genders,
                            onSelection: (val) {},
                            title: 'Gender');
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavSection(text: 'Update', onTap: () {}),
    );
  }
}
