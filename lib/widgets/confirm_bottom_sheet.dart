import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const ConfirmationBottomSheet({
    super.key,
    required this.title,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Drag Handle
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),

          /// Title Text
          CustomText(
            text: title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          /// Buttons
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Confirm Button
                CustomButton(
                  text: confirmText,
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                ),
                const SizedBox(width: 10),

                /// Cancel Button
                CustomOutlineButton(
                  text: cancelText,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
