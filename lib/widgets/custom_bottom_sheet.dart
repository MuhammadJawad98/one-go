import 'package:flutter/material.dart';

import '../models/selection_object.dart';
import 'custom_text.dart';

Future<SelectionObject?> showAwesomeBottomSheet(
    BuildContext context, String title, List<SelectionObject> items) async {
  return await showModalBottomSheet<SelectionObject>(
    context: context,
    isScrollControlled: true, // set to true to allow height control
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5, // starts at 50% height
        maxChildSize: 0.7,     // max height = 70% of screen
        minChildSize: 0.3,     // optional: minimum height
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                // Drag Handle (optional but nice UX)
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Title + Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const Divider(thickness: 1),

                // List of SelectionObjects
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: CustomText(text: item.title),
                        trailing: CustomText(text: item.value),
                        onTap: () {
                          Navigator.pop(context, item); // Return selected item
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
