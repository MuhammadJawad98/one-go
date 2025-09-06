import 'package:flutter/material.dart';

import '../../../models/service_detail_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/feature_tile_widget.dart';

class ServiceSpecificationSection extends StatelessWidget {
  final ServiceDetailModel serviceDetail;

  const ServiceSpecificationSection({super.key, required this.serviceDetail});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (serviceDetail.categoryName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.category,
            title: 'Category',
            subtitle: serviceDetail.categoryName,
            color: AppColors.primaryColor,
            showCheckmark: false,
          ),

        if (serviceDetail.businessName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.business,
            title: 'Business',
            subtitle: serviceDetail.businessName,
            color: AppColors.primaryColor,
            showCheckmark: false,
          ),

        if (serviceDetail.branchName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.location_on,
            title: 'Branch',
            subtitle: serviceDetail.branchName,
            color: AppColors.primaryColor,
            showCheckmark: false,
          ),

        if (serviceDetail.cityName.isNotEmpty)
          CustomFeatureTile(
            icon: Icons.location_city,
            title: 'City',
            subtitle: serviceDetail.cityName,
            color: AppColors.primaryColor,
            showCheckmark: false,
          ),
      ],
    );
  }
}