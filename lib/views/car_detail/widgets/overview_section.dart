import 'package:flutter/material.dart';

import '../../../models/car_detail_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_empty_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/feature_tile_widget.dart';

class AboutSection extends StatelessWidget {
  final CarDetailsModel carDetailsModel;

  const AboutSection({super.key, required this.carDetailsModel});

  @override
  Widget build(BuildContext context) {
    // Check if all car detail values are empty
    final bool hasNoDetails =
        carDetailsModel.makeName.isEmpty &&
        carDetailsModel.modelName.isEmpty &&
        carDetailsModel.year.isEmpty &&
        carDetailsModel.variant.isEmpty &&
        carDetailsModel.color.isEmpty &&
        carDetailsModel.conditionType.isEmpty &&
        carDetailsModel.mileage.isEmpty &&
        carDetailsModel.fuelType.isEmpty &&
        carDetailsModel.transmission.isEmpty &&
        carDetailsModel.driveType.isEmpty &&
        carDetailsModel.bodyType.isEmpty &&
        carDetailsModel.engineSize.isEmpty &&
        carDetailsModel.cylinders.isEmpty &&
        carDetailsModel.noOfSeats.isEmpty &&
        carDetailsModel.regionalSpecs.isEmpty &&
        carDetailsModel.optionLevel.isEmpty;

    if (hasNoDetails) {
      return const CustomEmptyView(
        title: 'No car information found',
        subtitle: 'Car details will be added soon',
        icon: Icons.car_repair,
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Expanded(
              child: customItemContainer(
                Icons.local_gas_station,
                'Fuel Type',
                carDetailsModel.fuelType,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: customItemContainer(
                Icons.flash_on,
                'Engine Size',
                carDetailsModel.engineSize,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: customItemContainer(
                Icons.airline_seat_legroom_extra_outlined,
                'Seats',
                carDetailsModel.noOfSeats,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        if (carDetailsModel.makeName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.branding_watermark,
            title: 'Make',
            subtitle: carDetailsModel.makeName,
            showCheckmark: false,
          ),
        if (carDetailsModel.modelName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.model_training,
            title: 'Model',
            subtitle: carDetailsModel.modelName,
            showCheckmark: false,
          ),
        if (carDetailsModel.year.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.calendar_today,
            title: 'Year',
            subtitle: carDetailsModel.year,
            showCheckmark: false,
          ),
        if (carDetailsModel.variant.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.category,
            title: 'Variant',
            subtitle: carDetailsModel.variant,
            showCheckmark: false,
          ),
        if (carDetailsModel.color.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.color_lens,
            title: 'Color',
            subtitle: carDetailsModel.color,
            showCheckmark: false,
          ),
        if (carDetailsModel.conditionType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.build,
            title: 'Condition',
            subtitle: carDetailsModel.conditionType,
            showCheckmark: false,
          ),
        if (carDetailsModel.mileage.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.speed,
            title: 'Mileage',
            subtitle: carDetailsModel.mileage,
            showCheckmark: false,
          ),
        if (carDetailsModel.transmission.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.settings,
            title: 'Transmission',
            subtitle: carDetailsModel.transmission,
            showCheckmark: false,
          ),
        if (carDetailsModel.driveType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.directions_car,
            title: 'Drive Type',
            subtitle: carDetailsModel.driveType,
            showCheckmark: false,
          ),
        if (carDetailsModel.bodyType.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.car_repair,
            title: 'Body Type',
            subtitle: carDetailsModel.bodyType,
            showCheckmark: false,
          ),
        if (carDetailsModel.cylinders.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.engineering,
            title: 'Cylinders',
            subtitle: carDetailsModel.cylinders,
            showCheckmark: false,
          ),
        if (carDetailsModel.regionalSpecs.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.public,
            title: 'Regional Specs',
            subtitle: carDetailsModel.regionalSpecs,
            showCheckmark: false,
          ),
        if (carDetailsModel.optionLevel.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.star_outline,
            title: 'Option Level',
            subtitle: carDetailsModel.optionLevel,
            showCheckmark: false,
          ),
      ],
    );
  }

  Widget customItemContainer(IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.screenBgColor,
        border: Border.all(color: AppColors.greyColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          CustomText(text: value, fontSize: 14, fontWeight: FontWeight.w500),
          CustomText(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
