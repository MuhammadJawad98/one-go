import 'package:flutter/material.dart';
import 'package:car_wash_app/models/car_listing_model.dart';
import 'package:car_wash_app/utils/app_colors.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/riyal_price_widget.dart';

class CarCardWidget extends StatelessWidget {
  final CarListingModel model;
  final VoidCallback? onTap;

  const CarCardWidget({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    final accentColor = model.isFeatured
        ? Colors.amber
        : AppColors.primaryColor;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
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
              height: 140,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: name + price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            text:
                                '${model.makeName} ${model.modelName} (${model.year})',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RiyalPriceWidget(
                          child: CustomText(
                            text: model.listingPrice,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // specs row chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (model.transmission.isNotEmpty == true)
                          _specChip(
                            Icons.settings_ethernet,
                            model.transmission,
                          ),
                        if (model.engineSize.isNotEmpty == true)
                          _specChip(Icons.local_gas_station, model.engineSize),
                        // if (model.noOfSeats > 0)
                        _specChip(Icons.event_seat, '${model.noOfSeats} seats'),
                        if (model.color.isNotEmpty == true)
                          _specChip(Icons.color_lens, model.color),
                        _specChip(Icons.speed, '${model.mileage} km'),
                        _specChip(
                          Icons.location_on_outlined,
                          'City #${model.cityId}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // footer: status + featured badge (if any)
                    Row(
                      children: [
                        _statusChip(model.status),
                        const Spacer(),
                        if (model.isFeatured)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withAlpha(15),
                              border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, size: 14, color: Colors.amber),
                                SizedBox(width: 6),
                                CustomText(
                                  text: 'Featured',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withAlpha(8),
        border: Border.all(color: AppColors.primaryColor.withAlpha(25)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          CustomText(
            text: text,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final lc = status.toLowerCase();
    Color c = AppColors.primaryColor;
    if (lc == 'new') c = Colors.teal;
    if (lc == 'used') c = Colors.blueGrey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.withAlpha(12),
        border: Border.all(color: c.withAlpha(35)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: CustomText(
        text: status.isEmpty ? '—' : status,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: c,
      ),
    );
  }
}
