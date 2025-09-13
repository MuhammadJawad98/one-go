import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/selection_object.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/riyal_price_widget.dart';

class FilterBottomSheetContent extends StatefulWidget {
  const FilterBottomSheetContent({super.key});

  @override
  State<FilterBottomSheetContent> createState() =>
      _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  // RangeValues _priceRange = const RangeValues(5000, 15000);
  SelectionObject? _selectedCondition;
  SelectionObject? _selectedMake;
  SelectionObject? _selectedModel;
  SelectionObject? _selectedType;
  SelectionObject? _selectedFromYear;
  SelectionObject? _selectedToYear;
  String? _minMileage;
  String? _maxMileage;
  // String? _keyword;

  List<SelectionObject> yearOptions = [];
  // Filter Options Data
  final List<SelectionObject> conditionOptions = [
    SelectionObject(id: '1', title: 'New',value: 'new', isSelected: false),
    SelectionObject(id: '2', title: 'Used',value: 'used', isSelected: false),
    // SelectionObject(id: '3', title: 'Certified',value: 'certified', isSelected: false),
  ];


  final List<SelectionObject> typeOptions = [
    SelectionObject(id: '1', title: 'All',value: 'all', isSelected: true),
    SelectionObject(id: '2', title: 'SUV',value: 'suv', isSelected: false),
    SelectionObject(id: '3', title: 'Sedan',value: 'sedan', isSelected: false),
    SelectionObject(id: '4', title: 'Coupe',value: 'coupe', isSelected: false),
    SelectionObject(id: '5', title: 'Hatchback',value: 'hatchback', isSelected: false),
    SelectionObject(id: '6', title: 'Convertible',value: 'convertible', isSelected: false),
    SelectionObject(id: '7', title: 'Minivan',value: 'minivan', isSelected: false),
    SelectionObject(id: '8', title: 'Pickup',value: 'pickup', isSelected: false),
    SelectionObject(id: '9', title: 'Van',value: 'van', isSelected: false),
    SelectionObject(id: '10', title: 'Wagon',value: 'wagon', isSelected: false),
    SelectionObject(id: '11', title: 'other',value: 'other', isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      final int currentYear = DateTime.now().year;

      yearOptions = [
        // SelectionObject(id: '0', title: 'All', value: 'all', isSelected: true),
        ...List.generate(
          currentYear - 1990 + 1,
              (index) {
            final year = currentYear - index;
            return SelectionObject(
              id: (index + 1).toString(),
              title: year.toString(),
              value: year.toString(),
              isSelected: false,
            );
          },
        ),
      ];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
  }

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
                        onChanged: (value){
                          setState(() => _selectedMake = value);
                          provider.fetchModels(context, _selectedMake!.id);
                        }
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
                      Row(
                        children: [
                          Expanded(child: _buildFilterDropdown(
                            'From Year',
                            yearOptions,
                            value: _selectedFromYear,
                            onChanged: (value) =>
                                setState(() => _selectedFromYear = value),
                          )),
                          const SizedBox(width: 16),
                          Expanded(child: _buildFilterDropdown(
                            'To Year',
                            yearOptions,
                            value: _selectedToYear,
                            onChanged: (value) =>
                                setState(() => _selectedToYear = value),
                          )),

                        ],
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
                      Row(
                        children: [
                          const CustomText(
                            text: 'Price Range',
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 8),
                          const CustomText(
                            text: '( ',
                            fontWeight: FontWeight.bold,
                          ),
                          RiyalPriceWidget(child: SizedBox()),
                          const CustomText(
                            text: ')',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // MIN
                          Expanded(
                              child: RoundedTextField(
                                hintText: 'Min',
                                controller: _minPriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              )
                          ),
                          const SizedBox(width: 12),
                          // MAX
                          Expanded(
                              child: RoundedTextField(
                                hintText: 'Max',
                                controller: _maxPriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Apply Button
                      SafeArea(
                        child: CustomButton(
                          text: 'APPLY FILTERS',
                          onPressed: () {
                            // You can use the filter values here before closing
                            int? fromYear = _selectedFromYear!=null && _selectedFromYear?.value!=null ? (int.parse(_selectedFromYear!.value) < 1900 ? 1900 : int.parse(_selectedFromYear!.value)) : null;
                            int? toYear = _selectedToYear!=null && _selectedFromYear?.value!=null ? (int.parse(_selectedFromYear!.value) < 1900 ? 1900 : int.parse(_selectedToYear!.value)) : null;
                            Provider.of<DashboardProvider>(context,listen: false).fetchCars(context,
                            keyword: _searchController.text.trim(),
                            conditionType: _selectedCondition?.value,
                            makeSlug: _selectedMake?.value,
                            modelSlug: _selectedModel?.value,
                            bodyType: _selectedType?.value,
                            minYear: fromYear?.toString(),
                            maxYear: toYear?.toString(),
                            minMileage: _minMileage,
                            maxMileage: _maxMileage,
                            minPrice: _minPriceController.text.trim(),
                            maxPrice: _maxPriceController.text.trim(),
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
