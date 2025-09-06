import 'package:flutter/material.dart';

import '../../../models/service_detail_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class OperatingHoursSection extends StatelessWidget {
  final OperatingHours operatingHours;

  const OperatingHoursSection({super.key, required this.operatingHours});

  @override
  Widget build(BuildContext context) {
    final days = [
      {'day': 'Monday', 'hours': operatingHours.monday},
      {'day': 'Tuesday', 'hours': operatingHours.tuesday},
      {'day': 'Wednesday', 'hours': operatingHours.wednesday},
      {'day': 'Thursday', 'hours': operatingHours.thursday},
      {'day': 'Friday', 'hours': operatingHours.friday},
      {'day': 'Saturday', 'hours': operatingHours.saturday},
      {'day': 'Sunday', 'hours': operatingHours.sunday},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Operating Hours',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 16),
          ...days.map((day) => _buildDayRow(
            day['day'] as String,
            day['hours'] as DayHours,
          )),
        ],
      ),
    );
  }

  Widget _buildDayRow(String day, DayHours hours) {
    final isOpen = hours.open.isNotEmpty && hours.close.isNotEmpty;
    final timeText = isOpen ? '${hours.open} - ${hours.close}' : 'Closed';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomText(
              text: day,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            flex: 3,
            child: CustomText(
              text: timeText,
              fontSize: 14,
              color: isOpen ? AppColors.blackColor : AppColors.errorColor,
            ),
          ),
        ],
      ),
    );
  }
}