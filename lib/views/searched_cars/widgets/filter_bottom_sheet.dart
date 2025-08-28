import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/selection_object.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class FilterBottomSheetContent extends StatefulWidget {
  const FilterBottomSheetContent({super.key});

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  final TextEditingController _searchController = TextEditingController();
  RangeValues _priceRange = const RangeValues(5000, 15000);
  SelectionObject? _selectedCondition;
  SelectionObject? _selectedMake;
  SelectionObject? _selectedModel;
  SelectionObject? _selectedType;
  SelectionObject? _selectedYear;
  String? _minMileage;
  String? _maxMileage;
  String? _keyword;

  // Filter Options Data
  final List<SelectionObject> conditionOptions = [
    SelectionObject(id: '1', title: 'New',value: 'new', isSelected: false),
    SelectionObject(id: '2', title: 'Used',value: 'used', isSelected: false),
    SelectionObject(id: '3', title: 'Certified',value: 'certified', isSelected: false),
  ];


  final List<SelectionObject> typeOptions = [
    SelectionObject(id: '1', title: 'All',value: 'all', isSelected: true),
    SelectionObject(id: '2', title: 'SUV',value: 'sUV', isSelected: false),
    SelectionObject(id: '3', title: 'Sedan',value: 'sedan', isSelected: false),
    SelectionObject(id: '4', title: 'Coupe',value: 'coupe', isSelected: false),
    SelectionObject(id: '5', title: 'Hatchback',value: 'hatchback', isSelected: false),
  ];

  final List<SelectionObject> yearOptions = [
    SelectionObject(id: '1', title: 'All',value: 'all', isSelected: true),
    SelectionObject(id: '2', title: '2023',value: '2023', isSelected: false),
    SelectionObject(id: '3', title: '2022',value: '2022', isSelected: false),
    SelectionObject(id: '4', title: '2021',value: '2021', isSelected: false),
    SelectionObject(id: '5', title: '2020',value: '2020', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Search Filters',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Field
                      RoundedTextField(
                        hintText: 'Enter Keyword',
                        controller: _searchController,
                      ),
                      const SizedBox(height: 16),

                      // Filter Options
                      _buildFilterDropdown(
                        'Condition',
                        conditionOptions,
                        value: _selectedCondition,
                        onChanged: (value) =>
                            setState(() => _selectedCondition = value),
                      ),
                      _buildFilterDropdown(
                        'Select Makes',
                        provider.makes,
                        value: _selectedMake,
                        onChanged: (value) =>
                            setState(() => _selectedMake = value),
                      ),
                      _buildFilterDropdown(
                        'Select Models',
                        provider.models,
                        value: _selectedModel,
                        onChanged: (value) =>
                            setState(() => _selectedModel = value),
                      ),
                      _buildFilterDropdown(
                        'Select Type',
                        typeOptions,
                        value: _selectedType,
                        onChanged: (value) =>
                            setState(() => _selectedType = value),
                      ),
                      _buildFilterDropdown(
                        'Year',
                        yearOptions,
                        value: _selectedYear,
                        onChanged: (value) =>
                            setState(() => _selectedYear = value),
                      ),

                      // Mileage Range
                      const CustomText(
                        text: 'Mileage',
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: RoundedTextField(hintText: 'Min')),
                          const SizedBox(width: 16),
                          Expanded(child: RoundedTextField(hintText: 'Max')),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Price Range
                      const CustomText(
                          text: 'Price', fontWeight: FontWeight.bold),
                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 50000,
                        divisions: 10,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.greyColor,
                        labels: RangeLabels(
                          'SAR ${_priceRange.start.round()}',
                          'SAR ${_priceRange.end.round()}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),

                      // Apply Button
                      SafeArea(
                        child: CustomButton(
                          text: 'APPLY FILTERS',
                          onPressed: () {
                            // You can use the filter values here before closing

                            Provider.of<DashboardProvider>(context,listen: false).fetchCars(context,
                            keyword: _searchController.text.trim(),
                            conditionType: _selectedCondition?.value,
                            makeSlug: _selectedMake?.value,
                            modelSlug: _selectedModel?.value,
                            bodyType: _selectedType?.value,
                            minYear: _selectedYear?.value,
                            minMileage: _minMileage,
                            maxMileage: _maxMileage,
                            minPrice: _priceRange.start.round().toString(),
                            maxPrice: _priceRange.end.round().toString(),
                            reset: true
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterDropdown(String title,
      List<SelectionObject> items, {
        required SelectionObject? value,
        required Function(SelectionObject) onChanged,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          CustomDropDown(
            value: value,
            list: items,
            onSelection: (val) {
              onChanged(val);
            },
            title: title,
          ),
        ],
      ),
    );
  }
}
