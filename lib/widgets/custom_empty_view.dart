import 'package:flutter/material.dart';

import '../localization/language_constraints.dart';
import '../utils/app_strings.dart';
import '../widgets/custom_text.dart';

class CustomEmptyView extends StatelessWidget {
  final String? text;

  const CustomEmptyView({super.key,this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CustomLottieAnim(asset: AppAssets.emptyView, size: size),
        // SizedBox(height: size.width * 0.02),
        CustomText(
            text: text ?? getTranslated(context, AppStrings.noDataFound),
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center)
      ],
    );
  }
}
