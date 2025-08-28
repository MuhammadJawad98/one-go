import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../models/service_detail_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../utils/app_colors.dart';

class ContactInfoSection extends StatelessWidget {
  final ServiceDetailModel serviceDetail;

  const ContactInfoSection({super.key, required this.serviceDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactItem(Octicons.person, 'Contact Person', serviceDetail.contactPerson),
          _buildContactItem(Feather.phone, 'Contact Number', serviceDetail.contactNumber),
          _buildContactItem(Feather.phone, 'Branch Phone', serviceDetail.branchPhone),
          _buildContactItem(MaterialIcons.alternate_email, 'Branch Email', serviceDetail.branchEmail),
          _buildContactItem(Octicons.location, 'Address', serviceDetail.branchStreetAddress),

        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: value.isNotEmpty ? value : 'Not available',
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}