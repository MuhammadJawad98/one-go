import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/selection_object.dart';
import '../../../../routes/app_navigation.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}


class _FilterBottomSheetState extends State<FilterBottomSheet> {
  SelectionObject? selectedType;
  SelectionObject? selectedMake;
  SelectionObject? selectedModel;
  SelectionObject? selectedPrice;

  List<SelectionObject> types = [
    SelectionObject(id: '1',title: 'All Status',isSelected: true),
    SelectionObject(id: '2',title: 'Used Cars'),
    SelectionObject(id: '3',title: 'New Cars'),
  ];
  
  List<SelectionObject> prices = [
    SelectionObject(id: '1',title: 'No Max Price'),
    SelectionObject(id: '2',title: '2000'),
    SelectionObject(id: '3',title: '5000'),
    SelectionObject(id: '4',title: '10000'),
    SelectionObject(id: '5',title: '20000'),
    SelectionObject(id: '6',title: '30000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
  builder: (context, provider, child) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CustomText(
                  text: 'Filter Options',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Divider(height: 1),
          SizedBox(height: 16),

          // Type dropdown
          CustomText(text: 'Type'),
          SizedBox(height: 5),
          CustomDropDown(
            list: types,
            value: selectedType,
            onSelection: (item) => setState(() => selectedType = item),
            title: 'Type',
          ),
          SizedBox(height: 16),

          // Make dropdown
          CustomText(text: 'Make'),
          SizedBox(height: 5),
          CustomDropDown(
            list: provider.makes,
            value: selectedMake,
            onSelection: (item){
              setState(() => selectedMake = item);
              provider.fetchModels(context, selectedMake!.id);
            },
            title: 'Make',
          ),
          SizedBox(height: 16),

          // Model dropdown
          CustomText(text: 'Model'),
          SizedBox(height: 5),
          CustomDropDown(
            list: provider.models,
            value: selectedModel,
            onSelection: (item) => setState(() => selectedModel = item),
            title: 'Model',
          ),
          SizedBox(height: 16),

          // Price dropdown
          CustomText(text: 'Price'),
          SizedBox(height: 5),
          CustomDropDown(
            list: prices,
            value: selectedPrice,
            onSelection: (item) => setState(() => selectedPrice = item),
            title: 'Price',
          ),
          SizedBox(height: 24),

          // Search button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: 'Search',
              onPressed: () {
                Provider.of<DashboardProvider>(context,listen: false).fetchCars(context,reset: true,makeSlug: selectedMake?.value ?? '');
                Navigator.pop(context);
                AppNavigation.navigateToSearchedItemsScreen(context);
                // You can also pass selected values to next screen
              },
            ),
          ),
          SafeArea(child: SizedBox(height: 16)),
        ],
      ),
    );
  },
);
  }
}
