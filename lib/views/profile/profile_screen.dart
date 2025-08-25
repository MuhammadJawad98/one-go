import 'package:car_wash_app/models/selection_object.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/views/profile/widgets/profile_image_widget.dart';
import 'package:car_wash_app/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SelectionObject> options = [
    SelectionObject(id: '1', title: 'Your Profile', image: AppAssets.user),
    SelectionObject(
      id: '2',
      title: 'Manage Address',
      image: AppAssets.locationProfileIcon,
    ),
    SelectionObject(id: '3', title: 'Payment Methods', image: AppAssets.card),
    SelectionObject(id: '4', title: 'My Orders', image: AppAssets.calendar),
    // SelectionObject(id: '5', title: 'My Wallet', image: AppAssets.wallet),
    SelectionObject(id: '6', title: 'Settings', image: AppAssets.setting),
    SelectionObject(id: '7', title: 'Help Center', image: AppAssets.infoCircle),
    SelectionObject(id: '8', title: 'Privacy Policy', image: AppAssets.lock),
    SelectionObject(
      id: '9',
      title: 'Invites Friends',
      image: AppAssets.profileAdd,
    ),
    SelectionObject(id: '10', title: 'Logout', image: AppAssets.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      CustomImageButton(onTap: () {}),
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
                SizedBox(height: 12),

                ///profile image
                ProfileImageWidget(fromProfile: true),
                SizedBox(height: 16),
                CustomText(
                  text: provider.userModel.name,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 28),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (options[index].id == '1') {
                              AppNavigation.navigateToYourProfile(context);
                            } else if (options[index].id == '2') {
                              AppNavigation.navigateToManageAddress(context);
                            }
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                options[index].image,
                                width: 24,
                                height: 24,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: CustomText(
                                  text: options[index].title,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.primaryColor,
                                size: 21,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: options.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
