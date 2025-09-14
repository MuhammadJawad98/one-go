import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/my_cars_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({super.key});

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Pricing & Final Details :',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              CustomText(
                text:
                    'Set your asking price and choose if you want to feature your listing.',
                fontWeight: FontWeight.w400,
                color: AppColors.lightGreyTextColor,
                fontSize: 12,
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  CustomText(
                    text: 'Listing Price ',
                    fontWeight: FontWeight.w500,
                  ),
                  RiyalPriceWidget(child: CustomText(text: ' *')),
                ],
              ),
              SizedBox(height: 5),
              RoundedTextField(
                controller: provider.priceController,
                hintText: 'Enter you asking price',
                keyboardType: TextInputType.number,
                maxLines: 1,
              ),
              SizedBox(height: 8),
              CustomText(
                text:
                    'Set a competitive price based on your car\'s condition and market value.',
                fontSize: 12,
                color: AppColors.lightGreyTextColor,
              ),

              SizedBox(height: 16),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primaryColor,
                          value: provider.isFeatureSelected,
                          onChanged: (val) {
                            setState(() {
                              provider.isFeatureSelected = val!;
                            });
                          },
                        ),
                        CustomText(text: 'Make this a Featured Listing',fontSize: 15),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primaryColor,
                          ),
                          child: CustomText(
                            text: 'Premium',
                            fontSize: 12,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(text: 'Featured Listing Benefits:',fontSize: 13,fontWeight: FontWeight.w500),
                    CustomText(text: '1. Priority placement in search results',fontSize: 14),
                    CustomText(text: '2. Special featured badge',fontSize: 14),
                    CustomText(text: '3. Higher visibility to potential buyers',fontSize: 14),
                    CustomText(text: '4. Enhanced listing analytics',fontSize: 14),
                    CustomText(text: '5. Faster selling potential',fontSize: 14),
                    CustomText(text: '6. Priority customer support',fontSize: 14),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
