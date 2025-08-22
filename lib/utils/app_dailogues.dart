import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../localization/language_constraints.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/responsive.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  var size = Responsive.getDynamicSize(context);

  bool shouldExit = false;

  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              text: AppStrings.appName,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 12),
            CustomText(
              text: getTranslated(context, AppStrings.exitText),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.redAccentColor,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 80,
                  text: getTranslated(context, AppStrings.no),
                  onPressed: () {
                    shouldExit = false;
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomOutlineButton(
                  width: 80,
                  text: getTranslated(context, AppStrings.yes),
                  onPressed: () {
                    shouldExit = true;
                    Navigator.of(context).pop();
                    if (Platform.isAndroid) {
                      SystemNavigator.pop(); // Properly close the app on Android
                    } else if (Platform.isIOS) {
                      exit(0); // Force close on iOS (use with caution)
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );

  return shouldExit;
}
