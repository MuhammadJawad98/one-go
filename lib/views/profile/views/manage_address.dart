import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_bottom_nav_section.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_text.dart';

class ManageAddresses extends StatefulWidget {
  const ManageAddresses({super.key});

  @override
  State<ManageAddresses> createState() => _ManageAddressesState();
}

class _ManageAddressesState extends State<ManageAddresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  CustomImageButton(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: 'Manage Address',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                  Image.asset(AppAssets.pin,width: 22,height: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: 'Home', fontSize: 14, fontWeight: FontWeight.w500),
                          CustomText(text: '1901 Thornridge Cir. Shiloh, Hawaii 81063',fontSize: 12),
                        ]))
                  ],);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                      height: 30,
                      child: Divider());
                },
                itemCount: 20,
              ),
            ),
            SizedBox(height: 16),
            DottedBorder(
              options: RectDottedBorderOptions(
                color: AppColors.primaryColor,
                strokeWidth: 1.5,
                dashPattern: [6, 3],
              ),
              child: InkWell(
                onTap: (){},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: AppColors.primaryColor, size: 20),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'Add New Address',
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavSection(text: 'Apply', onTap: () {}),
    );
  }
}
