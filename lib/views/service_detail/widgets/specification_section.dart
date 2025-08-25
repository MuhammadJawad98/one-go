import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificationSection extends StatelessWidget {
  const SpecificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            if(provider.carDetailsModel.features.blindSpotMonitor) customItem('Safety & Security',   'Blind Spot Monitor' ),
            if(provider.carDetailsModel.features.ledHeadlights) customItem('Lighting', 'LED Headlights\nAmbient Lighting'),
            if(provider.carDetailsModel.features.premiumSound) customItem('Entertainment & Connectivity', 'Premium Sound System'),
            if(provider.carDetailsModel.features.digitalDisplayMirror) customItem('Display & Controls', 'Digital Display Mirror'),
            if(provider.carDetailsModel.features.newTyres) customItem('Maintenance & Condition', 'New Tyres'),
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
