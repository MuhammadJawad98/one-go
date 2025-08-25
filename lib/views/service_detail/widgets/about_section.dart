import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/selection_object.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            customItem("Make", provider.carDetailsModel.makeName),
            customItem("Model", provider.carDetailsModel.modelName),
            customItem("Year", provider.carDetailsModel.year),
            customItem("Variant", provider.carDetailsModel.variant),
            customItem("Color", provider.carDetailsModel.color),
            customItem("Condition", provider.carDetailsModel.conditionType),
            customItem("Mileage", provider.carDetailsModel.mileage),
            customItem("Fuel Type", provider.carDetailsModel.fuelType),
            customItem("Transmission", provider.carDetailsModel.transmission),
            customItem("Drive Type", provider.carDetailsModel.driveType),
            customItem("Body Type", provider.carDetailsModel.bodyType),
            customItem("Engine Size", provider.carDetailsModel.engineSize),
            customItem("Cylinders", provider.carDetailsModel.cylinders),
            customItem("Seats", provider.carDetailsModel.noOfSeats),
            customItem(
              "Regional Specs",
              provider.carDetailsModel.regionalSpecs,
            ),
            customItem("Option Level", provider.carDetailsModel.optionLevel),
          ],
        );
      },
    );
  }

  Widget customItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              text: '$title:',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomText(text: value, fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
