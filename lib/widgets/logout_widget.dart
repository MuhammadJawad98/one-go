import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../localization/language_constraints.dart';
import '../utils/app_strings.dart';
import 'custom_button.dart';
import 'custom_text.dart';

void showLogoutBottomSheet(BuildContext context) {
  var size = Responsive.getDynamicSize(context);
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// **Drag Handle**
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 20),

            /// **Logout Text**
            CustomText(
              text: getTranslated(context, AppStrings.logoutText),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            /// **Buttons Row**
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// **Yes Button**
                  CustomButton(
                      text: getTranslated(context, AppStrings.yes),
                      onPressed: () {
                        Navigator.pop(context);
                        // Provider.of<AuthProvider>(context,listen: false).doLogout(context);
                      },
                     ),
                  const SizedBox(width: 10),

                  /// **Cancel Button**
                  CustomOutlineButton(
                      text: getTranslated(context, AppStrings.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                     ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
