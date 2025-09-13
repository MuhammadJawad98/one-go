import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/selection_object.dart';
import '../../../../routes/app_navigation.dart';
import '../../../../utils/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_text.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  SelectionObject selectedType = SelectionObject(
    id: '1',
    title: 'Cars',
    isSelected: true,
  );
  SelectionObject? selectedMake;
  SelectionObject? selectedModel;
  SelectionObject? selectedPrice;

  ///auto care or auto maintenance
  SelectionObject? selectedCategory;
  SelectionObject? selectedCity;

  List<SelectionObject> types = [
    SelectionObject(id: '1', title: 'Cars', isSelected: true),
    SelectionObject(id: '2', title: 'Auto Care'),
    SelectionObject(id: '3', title: 'Auto Maintenance'),
  ];

  List<SelectionObject> prices = [
    SelectionObject(id: '1', title: 'All Prices'),
    SelectionObject(id: '2', title: 'Under 50,000 SAR', maxPrice: '50000'),
    SelectionObject(
      id: '3',
      title: '50,000 - 10,000 SAR',
      minPrice: '50000',
      maxPrice: '10000',
    ),
    SelectionObject(
      id: '4',
      title: '10,000 - 20,000 SAR',
      minPrice: '10000',
      maxPrice: '20000',
    ),
    SelectionObject(
      id: '5',
      title: '20,000 - 50,000 SAR',
      minPrice: '20000',
      maxPrice: '50000',
    ),
    SelectionObject(id: '6', title: 'Over 50,000 SAR', minPrice: '50000',maxPrice: '50000'),
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

              Center(
                child: Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: List.generate(types.length, (index) {
                    final e = types[index];
                    return GestureDetector(
                      onTap: () => selectType(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: e.isSelected
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withAlpha(50),
                        ),
                        child: CustomText(
                          text: e.title,
                          color: e.isSelected ? AppColors.whiteColor : AppColors.primaryColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 16),

              // Make dropdown
              if (selectedType.id == '1') ...[
                CustomText(text: 'Make'),
                SizedBox(height: 5),
                CustomDropDown(
                  list: provider.makes,
                  value: selectedMake,
                  onSelection: (item) {
                    setState(() => selectedMake = item);
                    provider.fetchModels(context, selectedMake!.id);
                  },
                  title: 'Make',
                ),
              ],

              if (selectedType.id != '1') ...[
                CustomText(text: 'Category'),
                SizedBox(height: 5),
                CustomDropDown(
                  list: provider.categoryList,
                  value: selectedCategory,
                  onSelection: (item) {
                    setState(() => selectedCategory = item);
                  },
                  title: 'Category',
                ),
              ],

              SizedBox(height: 16),

              // Model dropdown
              if (selectedType.id == '1') ...[
                CustomText(text: 'Model'),
                SizedBox(height: 5),
                CustomDropDown(
                  list: provider.models,
                  value: selectedModel,
                  onSelection: (item) => setState(() => selectedModel = item),
                  title: 'Model',
                ),
              ],

              if (selectedType.id != '1') ...[
                CustomText(text: 'City'),
                SizedBox(height: 5),
                CustomDropDown(
                  list: provider.cities,
                  value: selectedCity,
                  onSelection: (item) => setState(() => selectedCity = item),
                  title: 'City',
                ),
              ],

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
                    if(selectedType.id == '1'){
                      Provider.of<DashboardProvider>(context,listen: false).fetchCars(
                        context,
                        reset: true,
                        make: selectedMake?.value,
                        model: selectedModel?.value,
                        maxPrice: selectedPrice?.maxPrice,
                        minPrice: selectedPrice?.minPrice,
                      );
                      Navigator.pop(context);
                      AppNavigation.navigateToSearchedItemsScreen(context);
                    }else{
                      provider.fetchServices(context,
                          categorySlug: selectedCategory?.value,
                          citySlug: selectedCity?.value,
                          maxPrice: selectedPrice?.maxPrice,
                          reset: true);
                      Navigator.pop(context);
                      AppNavigation.navigateToServicesScreen(context,hasFilters: true);
                    }
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

  void selectType(int index) {
    setState(() {
      for (var i = 0; i < types.length; i++) {
        types[i].isSelected = i == index; // only tapped = true
      }
      selectedType = types[index]; // keep this in sync if you use it
    });
  }

}
