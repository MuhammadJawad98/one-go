import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../utils/app_assets.dart';
import '../../views/searched_cars/widgets/filter_bottom_sheet.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import 'widgets/car_cards_widget.dart';

class SearchedCarsScreen extends StatefulWidget {
  const SearchedCarsScreen({super.key});

  @override
  State<SearchedCarsScreen> createState() => _SearchedCarsScreenState();
}

class _SearchedCarsScreenState extends State<SearchedCarsScreen> {
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      builder: (context) {
        return FilterBottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: AppColors.primaryColor,
          //   title: const Text('Search Cars'),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.filter_alt),
          //       onPressed: _showFilterBottomSheet,
          //     ),
          //   ],
          // ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SafeArea(
                  top: true,
                  bottom: false,
                  child: Row(
                    children: [
                      CustomImageButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: 'Searched Cars',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      CustomImageButton(
                        asset: AppAssets.filter,
                        onTap: () => _showFilterBottomSheet(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Results Count
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black, // Default text color
                    ),
                    children: [
                      const TextSpan(
                        text: 'We found ',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      TextSpan(
                        text: provider.totalSearchedCars.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' Cars available for you',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Car List
                Expanded(
                  child: provider.searchedCarsList.isEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'No Data Found!'),
                      SizedBox(height: 12),
                      SizedBox(
                          width: 200,
                          child: CustomButton(text: 'Tap to Refresh', onPressed: (){
                            provider.fetchCars(context);
                          }))
                    ],
                  ) : GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                          itemCount: provider.searchedCarsList.length,
                          itemBuilder: (context, index) {
                            return CarCard(
                              obj: provider.searchedCarsList[index],
                            );
                          },
                        ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
