import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/responsive.dart';

class ManuallyLocationEnterScreen extends StatefulWidget {
  const ManuallyLocationEnterScreen({super.key});

  @override
  State<ManuallyLocationEnterScreen> createState() =>
      _ManuallyLocationEnterScreenState();
}

class _ManuallyLocationEnterScreenState
    extends State<ManuallyLocationEnterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = Responsive.getDynamicSize(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                children: [
                  CustomImageButton(),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: 'Enter Your Location',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            RoundedTextField(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  AppAssets.search,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              sufixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.asset(
                  AppAssets.close,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
              hintText: 'Search Here...',
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Image.asset(AppAssets.directUp, width: 24, height: 24),
                SizedBox(width: 12),
                CustomText(
                  text: 'Use my current location ',
                  fontSize: 16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: AppColors.greyColor),
            const SizedBox(height: 16),
            CustomText(text: 'SEARCH RESULT'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) {
                  return Material(
                    color: AppColors.whiteColor,
                    child: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppAssets.directUp,
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(width: 6),
                                CustomText(text: 'Golden Avenue', fontSize: 16),
                              ],
                            ),
                            SizedBox(height: 6),
                            CustomText(
                              text: '8502 Preston Rd. Ingl..',
                              color: AppColors.lightGreyTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
