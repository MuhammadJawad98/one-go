import 'package:car_wash_app/main.dart';
import 'package:car_wash_app/utils/app_strings.dart';
import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';
import 'app_colors.dart';

class AppAlerts {
  static showCustomPopupAlert({
    required BuildContext context,
    String title = AppStrings.appName,
    required String text,
    String? noBtnText,
    String? yesBtnText,
    required VoidCallback onTapConfirm,
    VoidCallback? onTapNo,
  }) {
    return showDialog(
      //  barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        var size = Responsive.getDynamicSize(context);
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: title, fontWeight: FontWeight.w600),
              SizedBox(height: size.width * 0.02),
              CustomText(text: text),
              if (noBtnText != null || yesBtnText != null)
                SizedBox(height: size.width * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (noBtnText != null)
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          if (onTapNo != null) {
                            onTapNo();
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.02,
                            horizontal: size.width * 0.05,
                          ),
                          child: Text(
                            noBtnText,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (yesBtnText != null) SizedBox(width: size.width * 0.02),
                  if (yesBtnText != null)
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          onTapConfirm();
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: size.width * 0.02,
                            horizontal: size.width * 0.05,
                          ),
                          child: Text(
                            yesBtnText,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static void showSnackBar(
    String msg, {
    int statusCode = 0, // 0 = success (green), 1 = failure (red)
    String title = AppStrings.appName,
  }) {
    var context = NavigationService.navigatorKey.currentState!.context;
    Color backgroundColor = statusCode == 0
        ? AppColors.primaryColor
        : AppColors.errorColor;
    IconData icon = statusCode == 0 ? Icons.check_circle : Icons.error;

    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Define max width and responsive margins
    double maxWidth = screenWidth * 0.9; // Default for mobile
    double horizontalMargin = 16; // Default for mobile

    if (screenWidth > 600) {
      // Tablet
      maxWidth = screenWidth * 0.5;
      horizontalMargin = 24;
    }
    if (screenWidth > 1200) {
      // Desktop/Web
      maxWidth = screenWidth * 0.5;
      horizontalMargin = 32;
    }
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 5),
      content: Container(
        width: maxWidth,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: title,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(text: msg, color: Colors.white, fontSize: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
