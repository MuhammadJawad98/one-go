import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../routes/app_navigation.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_sharedpref.dart';
import '../utils/application_shared_instance.dart';
import '../utils/helper_functions.dart';
import '../utils/print_log.dart';
import '../widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _initializeApp());
  }

  void _initializeApp() async {
    try {
      Provider.of<DashboardProvider>(context,listen: false).initializeCommonData();
      final results = await Future.wait([
        HelperFunctions.getFromPreference(AppSharedPref.userData),
        HelperFunctions.getFromPreference(AppSharedPref.authToken),
        HelperFunctions.getFromPreference(AppSharedPref.isFirstTime),
      ]);

      final data = results[0];
      final authToken = results[1];
      final isFirstTime = results[2];

      DataManager().authToken = authToken;
      await Future.delayed(const Duration(seconds: 3));
      if (data.isNotEmpty) {
        final userMap = jsonDecode(data);
        Provider.of<DashboardProvider>(context,listen: false).setUserModel({"user":userMap, "accessToken" :authToken});
        AppNavigation.navigateToDashboardScreen(context);
      } else {
        if(isFirstTime.isNotEmpty && isFirstTime == '1'){
          AppNavigation.navigateToLoginScreen(context);
        }else{
          AppNavigation.navigateToWelcomeScreen(context);
        }
      }
    } catch (e, st) {
      PrintLogs.printLog('Initialization error: $e\n$st');
      AppNavigation.navigateToWelcomeScreen(context); // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.logo, width: 250, height: 250),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Consumer<DashboardProvider>(
              builder: (context, provider, child) {
                return provider.appVersion.isNotEmpty
                    ? SafeArea(
                        child: Center(
                          child: CustomText(
                            text: provider.appVersion,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
