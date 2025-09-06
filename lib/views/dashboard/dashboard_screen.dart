import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../views/dashboard/home/home.dart';
import '../../views/profile/profile_screen.dart';
import '../../widgets/custom_text.dart';
import '../favourite_screen/favourite_screen.dart';
import '../messages/messages_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    FavoritesScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  Widget _customNavItem(String assets, String label, int index) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
            ),
          ),
          const SizedBox(height: 6),
          Image.asset(
            assets,
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: label,
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      Provider.of<DashboardProvider>(context, listen: false).initApiCalls(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fieldBgColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          border: Border(
            top: BorderSide(color: AppColors.greyColor, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _customNavItem(AppAssets.home, "Home", 0),
              _customNavItem(AppAssets.bookmark, "Favourites", 1),
              _customNavItem(AppAssets.messageIcon, "Messages", 2),
              _customNavItem(AppAssets.profile, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }
}
