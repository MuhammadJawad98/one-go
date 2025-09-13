import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../models/order_model.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/riyal_price_widget.dart';
import 'status_chip_widget.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderModel vm;

  const OrderCardWidget({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(vm.status);

    return GestureDetector(
      onTap: (){
        AppNavigation.navigateToOrderDetailScreen(context, vm);
      },
      child: Container(
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
              constraints: const BoxConstraints(minHeight: 180),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
              ),
            ),

            // content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // title + price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: vm.serviceName,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        RiyalPriceWidget(
                          child: CustomText(
                            text: vm.price,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // slot label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: CustomText(
                            text: vm.timeslotLabel,
                            color: Colors.black87,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (vm.status.toLowerCase() == 'cancelled') ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Reason: ',
                            fontWeight: FontWeight.w600,
                          ),
                          Expanded(
                            child: CustomText(
                              text: vm.cancellationReason,
                              maxLine: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                    // status chip + actions
                    Row(
                      children: [
                        StatusChip(
                          text: HelperFunctions.capitalizeFirstLetter(vm.status),
                          color: statusColor,
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryColor,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: CustomText(
                            text: 'View',
                            color: AppColors.whiteColor,
                            fontSize: 12,
                          ),
                        ),
                        // const SizedBox(width: 8),
                        // if (onCancel != null)
                        //   SizedBox(
                        //     height: 40,
                        //     child: OutlinedButton(
                        //       onPressed: onCancel,
                        //       style: OutlinedButton.styleFrom(
                        //         foregroundColor: Colors.redAccent,
                        //         side: const BorderSide(color: Colors.redAccent),
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //         padding: const EdgeInsets.symmetric(
                        //           horizontal: 14,
                        //         ),
                        //       ),
                        //       child: const Text('Cancel'),
                        //     ),
                        //   ),
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

  /// status color rule
  Color _statusColor(String s) {
    final v = s.toLowerCase();
    if (v == 'confirmed') return AppColors.greenAppColor;
    if (v == 'cancelled') return AppColors.redAppColor;
    return AppColors.greyColor; // upcoming / default
  }
}
