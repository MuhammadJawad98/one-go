import 'package:flutter/material.dart';

import '../../../models/selection_object.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class AboutSection extends StatelessWidget {
  // final List<SelectionObject> sizes;
  final int selectedSize;
  final ValueChanged<int> onSizeChanged;

  const AboutSection({
    super.key,
    // required this.sizes,
    required this.selectedSize,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'About',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),
          const CustomText(
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua Read more',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGreyTextColor,
          ),
          const SizedBox(height: 24),
          // const CustomText(
          //   text: 'Select Size',
          //   fontSize: 14,
          //   fontWeight: FontWeight.w500,
          // ),
          // const SizedBox(height: 12),
          // SizedBox(
          //   height: 70,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: sizes.length,
          //     itemBuilder: (context, index) {
          //       final selected = selectedSize == index;
          //       return GestureDetector(
          //         onTap: () => onSizeChanged(index),
          //         child: Container(
          //           width: 60,
          //           height: 60,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: selected
          //                 ? AppColors.primaryColor
          //                 : AppColors.greyColor.withAlpha(50),
          //           ),
          //           child: Center(
          //             child: CustomText(
          //               text: sizes[index].title,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w600,
          //               color: selected
          //                   ? AppColors.whiteColor
          //                   : AppColors.blackColor,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     separatorBuilder: (_, __) => const SizedBox(width: 6),
          //   ),
          // ),
          // const SizedBox(height: 100),
        ],
      ),
    );
  }
}
