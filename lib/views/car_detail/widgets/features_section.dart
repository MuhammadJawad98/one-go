import 'package:car_wash_app/widgets/custom_empty_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../models/car_detail_model.dart';
import 'package:flutter/material.dart';

import '../../../widgets/feature_tile_widget.dart';

class SpecificationSection extends StatelessWidget {
  final CarDetailsModel carDetailsModel;

  const SpecificationSection({super.key, required this.carDetailsModel});

  @override
  Widget build(BuildContext context) {
    // Check if all features are false
    final bool hasNoFeatures =
        !carDetailsModel.features.blindSpotMonitor &&
        !carDetailsModel.features.ledHeadlights &&
        !carDetailsModel.features.premiumSound &&
        !carDetailsModel.features.digitalDisplayMirror &&
        !carDetailsModel.features.newTyres;

    if (hasNoFeatures) {
      return const CustomEmptyView(
        title: 'No specifications found',
        subtitle: 'Check back later for updated information',
        icon: Icons.featured_play_list_outlined,
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        if (carDetailsModel.features.blindSpotMonitor)
          CustomFeatureTile(
            icon: Icons.security,
            title: 'Safety & Security',
            subtitle: 'Blind Spot Monitor',
          ),

        if (carDetailsModel.features.ledHeadlights)
          CustomFeatureTile(
            icon: Icons.lightbulb_outline,
            title: 'Lighting',
            subtitle: 'LED Headlights • Ambient Lighting',
          ),

        if (carDetailsModel.features.premiumSound)
          CustomFeatureTile(
            icon: Icons.audiotrack,
            title: 'Entertainment',
            subtitle: 'Premium Sound System',
          ),

        if (carDetailsModel.features.digitalDisplayMirror)
          CustomFeatureTile(
            icon: Octicons.mirror,
            title: 'Display & Controls',
            subtitle: 'Digital Display Mirror',
          ),

        if (carDetailsModel.features.newTyres)
          CustomFeatureTile(
            icon: Icons.directions_car,
            title: 'Maintenance',
            subtitle: 'New Tyres Installed',
          ),
      ],
    );
  }
}
