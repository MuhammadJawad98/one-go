import 'package:car_wash_app/widgets/riyal_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/selection_object.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ServiceFilterBottomSheetContent extends StatefulWidget {
  const ServiceFilterBottomSheetContent({super.key});

  @override
  State<ServiceFilterBottomSheetContent> createState() =>
      _ServiceFilterBottomSheetContentState();
}

class _ServiceFilterBottomSheetContentState
    extends State<ServiceFilterBottomSheetContent> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  SelectionObject? _selectedCategory;
  SelectionObject? _selectedCity;
  bool _featuredOnly = false;

  @override
  void initState() {
    super.initState();
    // Fetch categories and cities when the filter sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final provider = Provider.of<DashboardProvider>(context, listen: false);
      // provider.fetchCategories(context);
      // provider.fetchCities(context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
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
                    text: 'Service Filters',
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
                        hintText: 'Search services...',
                        controller: _searchController,
                        prefixIcon: Icon(Icons.search),
                      ),
                      const SizedBox(height: 16),

                      // Category Dropdown
                      _buildFilterDropdown(
                        'Category',
                        provider.categoryList,
                        value: _selectedCategory,
                        onChanged: (value) =>
                            setState(() => _selectedCategory = value),
                        hintText: 'Select Category',
                      ),
                      const SizedBox(height: 12),

                      // City Dropdown
                      _buildFilterDropdown(
                        'City',
                        provider.cities,
                        value: _selectedCity,
                        onChanged: (value) =>
                            setState(() => _selectedCity = value),
                        hintText: 'Select City',
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
                      // RangeSlider(
                      //   values: _priceRange,
                      //   min: 1,
                      //   max: 5000,
                      //   divisions: 50,
                      //   activeColor: AppColors.primaryColor,
                      //   inactiveColor: AppColors.greyColor,
                      //   labels: RangeLabels(
                      //     'SAR ${_priceRange.start.round()}',
                      //     'SAR ${_priceRange.end.round()}',
                      //   ),
                      //   onChanged: (RangeValues values) {
                      //     setState(() {
                      //       _priceRange = values;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     CustomText(
                      //       text: 'SAR ${_priceRange.start.round()}',
                      //       fontSize: 12,
                      //       color: AppColors.greyColor,
                      //     ),
                      //     CustomText(
                      //       text: 'SAR ${_priceRange.end.round()}',
                      //       fontSize: 12,
                      //       color: AppColors.greyColor,
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 16),

                      // Featured Services Toggle
                      Row(
                        children: [
                          Checkbox(
                            value: _featuredOnly,
                            onChanged: (value) {
                              setState(() {
                                _featuredOnly = value ?? false;
                              });
                            },
                            activeColor: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: CustomText(
                              text: 'Show featured services only',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'RESET',
                              backgroundColor: AppColors.blackColor.withAlpha(100),
                              textColor: AppColors.whiteColor,
                              onPressed: ()=> _resetFilters(provider),
                              borderRadius: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              text: 'APPLY FILTERS',
                              onPressed: () => _applyFilters(provider),
                              borderRadius: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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

  Widget _buildFilterDropdown(
    String title,
    List<SelectionObject> items, {
    required SelectionObject? value,
    required Function(SelectionObject?) onChanged,
    String hintText = 'Select',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontWeight: FontWeight.bold, fontSize: 14),
        const SizedBox(height: 8),
        CustomDropDown(
          value: value,
          list: items,
          onSelection: onChanged,
          title: hintText,
        ),
      ],
    );
  }

  void _resetFilters(DashboardProvider provider) {
    // setState(() {
    //   _searchController.clear();
    //   _priceRange = const RangeValues(0, 1000);
    //   _selectedCategory = null;
    //   _selectedCity = null;
    //   _featuredOnly = false;
    // });
    provider.fetchServices(context, reset: true);
    Navigator.pop(context);

  }

  void _applyFilters(DashboardProvider provider) {
    provider.fetchServices(
      context,
      search: _searchController.text.trim(),
      citySlug: _selectedCity?.value,
      minPrice: _minPriceController.text.trim(),
      maxPrice: _maxPriceController.text.trim(),
      // isFeatured: _featuredOnly ? 'true' : null,
      reset: true,
    );

    Navigator.pop(context);
  }
}
