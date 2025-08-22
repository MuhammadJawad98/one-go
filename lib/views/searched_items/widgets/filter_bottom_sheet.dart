import 'package:flutter/material.dart';

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
    SelectionObject(id: '1', title: 'New', isSelected: false),
    SelectionObject(id: '2', title: 'Used', isSelected: false),
    SelectionObject(id: '3', title: 'Certified', isSelected: false),
  ];

  final List<SelectionObject> makeOptions = [
    SelectionObject(id: '1', title: 'All', isSelected: true),
    SelectionObject(id: '2', title: 'Volvo', isSelected: false),
    SelectionObject(id: '3', title: 'Nissan', isSelected: false),
    SelectionObject(id: '4', title: 'Mercedes', isSelected: false),
    SelectionObject(id: '5', title: 'Audi', isSelected: false),
    SelectionObject(id: '6', title: 'BMW', isSelected: false),
    SelectionObject(id: '7', title: 'Land Rover', isSelected: false),
  ];

  final List<SelectionObject> modelOptions = [
    SelectionObject(id: '1', title: 'All', isSelected: true),
    SelectionObject(id: '2', title: 'XC90', isSelected: false),
    SelectionObject(id: '3', title: 'Gaspai', isSelected: false),
    SelectionObject(id: '4', title: 'S 560', isSelected: false),
    SelectionObject(id: '5', title: 'A8 L 55', isSelected: false),
    SelectionObject(id: '6', title: 'M8 Gran Coupe', isSelected: false),
    SelectionObject(id: '7', title: 'Range Rover', isSelected: false),
  ];

  final List<SelectionObject> typeOptions = [
    SelectionObject(id: '1', title: 'All', isSelected: true),
    SelectionObject(id: '2', title: 'SUV', isSelected: false),
    SelectionObject(id: '3', title: 'Sedan', isSelected: false),
    SelectionObject(id: '4', title: 'Coupe', isSelected: false),
    SelectionObject(id: '5', title: 'Hatchback', isSelected: false),
  ];

  final List<SelectionObject> yearOptions = [
    SelectionObject(id: '1', title: 'All', isSelected: true),
    SelectionObject(id: '2', title: '2023', isSelected: false),
    SelectionObject(id: '3', title: '2022', isSelected: false),
    SelectionObject(id: '4', title: '2021', isSelected: false),
    SelectionObject(id: '5', title: '2020', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
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
                    makeOptions,
                    value: _selectedMake,
                    onChanged: (value) => setState(() => _selectedMake = value),
                  ),
                  _buildFilterDropdown(
                    'Select Models',
                    modelOptions,
                    value: _selectedModel,
                    onChanged: (value) =>
                        setState(() => _selectedModel = value),
                  ),
                  _buildFilterDropdown(
                    'Select Type',
                    typeOptions,
                    value: _selectedType,
                    onChanged: (value) => setState(() => _selectedType = value),
                  ),
                  _buildFilterDropdown(
                    'Year',
                    yearOptions,
                    value: _selectedYear,
                    onChanged: (value) => setState(() => _selectedYear = value),
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
                  const CustomText(text: 'Price', fontWeight: FontWeight.bold),
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
  }

  Widget _buildFilterDropdown(
    String title,
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
