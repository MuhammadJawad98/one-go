import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../models/service_detail_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../utils/app_colors.dart';

class AboutServiceSection extends StatelessWidget {
  final ServiceDetailModel serviceDetail;

  const AboutServiceSection({super.key, required this.serviceDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'About Service',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),
          HtmlWidget(
            serviceDetail.description.isNotEmpty
                ? serviceDetail.description
                : 'No description available.',
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          // CustomText(
          //     text: serviceDetail.description.isNotEmpty
          //         ? serviceDetail.description
          //         : 'No description available.',
          //     fontSize: 14,
          //     color: AppColors.greyColor,
          //     fontWeight: FontWeight.w400,
          //   ),
          const SizedBox(height: 20),

          // Location Info
          Row(
            children: [
              Icon(Octicons.location, size: 20, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: CustomText(
                  text:
                      '${serviceDetail.branchStreetAddress}, ${serviceDetail.cityName}',
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
