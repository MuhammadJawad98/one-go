import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/my_cars_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Car Features :',fontWeight: FontWeight.w600,fontSize: 16),
                  CustomText(text: 'Select all the features that your car has. This helps buyers understand what they\'re getting.',fontWeight: FontWeight.w400,color: AppColors.lightGreyTextColor,fontSize: 12),
                  SizedBox(height: 16),

                  Row(children: [
                    Icon(Icons.safety_check_outlined,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Safety Features',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 0,
                    children: provider.safetyFeature.map((option)=> FilterChip(
                      label: CustomText(
                        text: option.title,
                        color: option.isSelected ? Colors.white : Colors.black,
                      ),
                      selected: option.isSelected,
                      selectedColor: AppColors.primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      checkmarkColor: Colors.white,
                      onSelected: (bool selected) {
                          option.isSelected = selected;
                          provider.addItem(option);
                      },
                    )).toList()
                  ),


                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.directions_car_filled_outlined,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Exterior Features',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: provider.exteriorFeatures.map((option)=> FilterChip(
                        label: CustomText(
                          text: option.title,
                          color: option.isSelected ? Colors.white : Colors.black,
                        ),
                        selected: option.isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                            option.isSelected = selected;
                            provider.addItem(option);
                        },
                      )).toList()
                  ),

                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.music_note_outlined,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Entertainment & Connectivity',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: provider.entertainmentConnectivity.map((option)=> FilterChip(
                        label: CustomText(
                          text: option.title,
                          color: option.isSelected ? Colors.white : Colors.black,
                        ),
                        selected: option.isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                            option.isSelected = selected;
                            provider.addItem(option);
                        },
                      )).toList()
                  ),

                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.assistant_navigation,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Driver Assistance',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: provider.driverAssistance.map((option)=> FilterChip(
                        label: CustomText(
                          text: option.title,
                          color: option.isSelected ? Colors.white : Colors.black,
                        ),
                        selected: option.isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                            option.isSelected = selected;
                            provider.addItem(option);
                        },
                      )).toList()
                  ),

                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.chair_alt_outlined,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Interior Comfort',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: provider.interiorComfort.map((option)=> FilterChip(
                        label: CustomText(
                          text: option.title,
                          color: option.isSelected ? Colors.white : Colors.black,
                        ),
                        selected: option.isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                            option.isSelected = selected;
                            provider.addItem(option);
                        },
                      )).toList()
                  ),

                  SizedBox(height: 8),
                  Row(children: [
                    Icon(Icons.build_circle_outlined,color: AppColors.primaryColor),
                    SizedBox(width: 8),
                    CustomText(text: 'Maintenance & Modifications',fontWeight: FontWeight.w500,color: AppColors.primaryColor),
                  ]),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 4,
                      runSpacing: 0,
                      children: provider.maintenanceModifications.map((option)=> FilterChip(
                        label: CustomText(
                          text: option.title,
                          color: option.isSelected ? Colors.white : Colors.black,
                        ),
                        selected: option.isSelected,
                        selectedColor: AppColors.primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                            option.isSelected = selected;
                            provider.addItem(option);
                        },
                      )).toList()
                  ),
                  SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.yellowAppColor.withAlpha(50),
                        border: Border.all(color: AppColors.yellowAppColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Selected Features Summary',fontWeight: FontWeight.w500,fontSize: 14),
                          CustomText(text: '${provider.selectedFeatureItems.length} features selected :',fontWeight: FontWeight.w300,fontSize: 12),
                          SizedBox(height: 8),
                          provider.selectedFeatureItems.isEmpty? Center(child: CustomText(text: 'No Features Selected yet!')) : Wrap(
                            spacing: 4,
                          runSpacing: 4,
                            children: provider.selectedFeatureItems.map((e)=> Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.whiteColor,
                                  border: Border.all(color: AppColors.yellowAppColor)
                                ),
                                child: CustomText(text: e.title,fontSize: 12))).toList(),
                          ),
                        ],
                      )),


                  SizedBox(height: 40),


                ]));
      },
    );
  }
}
