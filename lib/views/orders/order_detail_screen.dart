import 'package:flutter/material.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // left accent
                  Container(
                    width: 6,
                    constraints: const BoxConstraints(minHeight: 100),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Title + Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: order.serviceName,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          text:
                              "Booked: ${HelperFunctions.getDateTimeString(order.createdAt, format: 'dd MMM, yyyy hh:mm a')}",
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ),
                  RiyalPriceWidget(
                    child: CustomText(
                      text: order.price,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Booking Info
            _sectionTitle("Booking Info :"),
            _infoRow(Ionicons.time_outline, "Timeslot", order.timeslotLabel),
            _infoRow(Feather.calendar, "Created At", order.createdAt),
            _infoRow(
              Feather.chevrons_right,
              "Status",
              HelperFunctions.capitalizeFirstLetter(order.status),
              valueColor: statusColor,
            ),
            if (order.status.toLowerCase() == "cancelled")
              _infoRow(
                Icons.cancel,
                "Reason",
                order.cancellationReason,
                valueColor: AppColors.redAppColor,
              ),
            const SizedBox(height: 20),

            // Branch Info
            _sectionTitle("Branch Info :"),
            _infoRow(Icons.store, "Branch", order.branchName),
            _infoRow(Icons.business, "Business", order.businessName),
            _infoRow(Feather.map_pin, "Address", order.streetAddress),
            _infoRow(Feather.phone, "Phone", order.branchPhone),
            const SizedBox(height: 40),

            // Action
            // Center(
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       // example action: reorder
            //     },
            //     icon: const Icon(Icons.repeat),
            //     label: const Text("Reorder Service"),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.primaryColor,
            //       foregroundColor: Colors.white,
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 24,
            //         vertical: 12,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomText(text: title, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: label, fontSize: 13, color: Colors.black54),
                CustomText(
                  text: value.isNotEmpty ? value : "-",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String s) {
    final v = s.toLowerCase();
    if (v == 'confirmed') return AppColors.greenAppColor;
    if (v == 'cancelled') return AppColors.redAppColor;
    return AppColors.greyColor;
  }
}
