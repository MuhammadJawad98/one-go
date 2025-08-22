import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/common_function.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = isDarkModeEnabled(context);
    return Center(
        child: CircularProgressIndicator(
            color: isDarkMode ? AppColors.whiteColor : AppColors.primaryColor));
  }
}
